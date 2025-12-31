module mksite;

import root;
import libc;
import std::io, std::io::path, std::io::file, std::collections::map;

Allocator arena;
char[ushort.max * 3] arena_buffer;

fn int main(String[] args)
{
    libc::srand((uint) libc::time(null));
    ArenaAllocator a;

    a.init(&arena_buffer);
    arena = &a;

    HashMap{String, Page} pages;
    pages.tinit_with_key_values(
        "index.html", root::page(),
        "technologies/index.html", root::technologies::page(),
        "socials/index.html", root::socials::page(),
        "blog/index.html", root::blog::page(),
    );

    root::blog::populate(&pages);

    Path cwd = path::tcwd()!!;
    Path www = cwd.tappend("www")!!;

    if (!path::exists(www)) {
        path::mkdir(www)!!;
    } else {
        if (!path::is_dir(www)) {
            io::fprintfn(io::stderr(), "Expected %s to be a directory!", www);
            return 1;
        }
    }

    pages.@each(; String key, Page page) {
        @pool() {
            Path out = www.tappend(key)!!;
            Path dirname = out.dirname().to_tpath()!!;

            if (!path::exists(dirname)) {
                path::mkdir(dirname, true)!!;
            }
            File f = file::open(out.str_view(), "w")!!;

            io::fprintn(&f, @html(page))!!;

            f.close()!!;
        };
    };

	return 0;
}
