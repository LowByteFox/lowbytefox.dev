module components::code;

import mksite;
import std::io, std::io::file;
import std::os::process;
import libc;

struct Code (HtmlElement) {
    String file, lang, code;
}

fn usz? Code.to_html(&self, HtmlAttr attr, Formatter *formatter) @dynamic
    => formatter.printf(`%s`, highlight(self.lang, self.code));

fn String highlight(String lang, String code) @if(!$feature(HIGHLIGHT)) => code;

fn String highlight(String lang, String code) @if($feature(HIGHLIGHT))
{
    char[32] pth;
    libc::strcpy((ZString) &pth, "/tmp/code.XXXXXXXXXX");

    mktemp((ZString) &pth);

    String path = ((ZString) &pth).str_view();

    File f = file::open(path, "w")!!;
    f.write(code)!!;
    f.close()!!;

    SubProcess bun = process::create({"bun", "./shiki/highlight.ts", lang,
        path})!!;
    defer bun.join()!!;
    File stdout = bun.stdout();

    return read_fully_ACTUALLY_STREAMING(stdout)!!;
}

fn void mktemp(ZString path) @local
{
    String view = path.str_view();
    char[2][*] ranges = {
        {'A', 'Z'},
        {'a', 'z'},
        {'0', '9'},
    };

    foreach_r (&c : view) {
        if (*c == 'X') {
            int idx = libc::rand() % ranges.len;
            int choice = libc::rand() % (ranges[idx][1] - ranges[idx][0] + 1);

            *c = ranges[idx][0] + (char) choice;
        } else {
            break;
        }
    }
}

fn String? read_fully_ACTUALLY_STREAMING(File stream)
{
    @pool() {
        DString builder;
        builder.tinit();

        while (!stream.eof()) {
            char[4096] buffer;
            usz n = stream.read(&buffer)!;
            builder.append_bytes(buffer[:n]);
        }

        return builder.copy_str(mksite::arena);
    };
}

fn Html create(Code code)
{
    Div div;
    div.body.init(mem);

    if (code.file.len > 0) {
        div.body.push(@html((Paragraph) { code.file }));
    }

    div.body.push(@html(code));

    Html div_html = @html(div);

    @pipe(div_html, attr("class", "codeblock"));
    return div_html;
}
