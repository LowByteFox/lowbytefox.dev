module root::technologies;

import mksite;

import layouts::base;

fn Page page()
{
    Page page = mksite::create_page("LowByteFox's Website", "/technologies/");
    Main *content = base::apply(&page, -1);
    defer base::footer(&page);

    Html spacer = @html((Div) {});
    @pipe(spacer, attr("class", "spacer"));

    content.body.push(spacer);
    content.body.push(@html((Header) { 1, "Technologies"}));
    content.body.push(@html((RawHtml) "<p><em>breathes in</em></p>"));
    content.body.push(@html((Header) { 2, "Programming Languages"}));

    HtmlList list;
    list.items.push("C");
    list.items.push("C3");
    list.items.push("C++");
    list.items.push("C#");
    list.items.push("Crystal");
    list.items.push("Fortran");
    list.items.push("GDScript");
    list.items.push("Go");
    list.items.push("Haskell");
    list.items.push("Java");
    list.items.push("JavaScript");
    list.items.push("Kotlin");
    list.items.push("Lua");
    list.items.push("Pascal");
    list.items.push("Perl");
    list.items.push("PHP");
    list.items.push("Python");
    list.items.push("Ruby");
    list.items.push("Rust");
    list.items.push("TypeScript");
    list.items.push("Zig");

    content.body.push(@html(list));

    content.body.push(@html((Header) { 2, "Kinda Programming Languages"}));

    list = {};

    list.items.push("Bash");
    list.items.push("CSS");
    list.items.push("HTML");
    list.items.push("M4");
    list.items.push("POSIX Shell");
    content.body.push(@html(list));

    content.body.push(@html((Header) { 2, "Compilers"}));
    list = {};
    list.items.push("Clang");
    list.items.push("GCC");
    content.body.push(@html(list));

    content.body.push(@html((Header) { 2, "Build Tools"}));
    list = {};
    list.items.push("CMake");
    list.items.push("POSIX Make");
    list.items.push("Meson");
    content.body.push(@html(list));

    content.body.push(@html((Header) { 2, "Databases"}));
    list = {};
    list.items.push("MariaDB");
    list.items.push("MongoDB");
    list.items.push("Redis");
    list.items.push("Sqlite");
    content.body.push(@html(list));

    content.body.push(@html((Header) { 2, "JS Engines"}));
    list = {};
    list.items.push("Bun");
    list.items.push("Deno");
    list.items.push("Node");
    content.body.push(@html(list));

    content.body.push(@html((Header) { 2, "Frontend Frameworks"}));
    list = {};
    list.items.push("Alpine.js");
    list.items.push("Preact");
    list.items.push("React");
    list.items.push("Svelte");
    list.items.push("Vue");
    content.body.push(@html(list));

    content.body.push(@html((Header) { 2, "Metaframeworks"}));
    list = {};
    list.items.push("Nuxt.js");
    list.items.push("SvelteKit");
    content.body.push(@html(list));

    content.body.push(@html((Header) { 2, "Code Editors"}));
    list = {};
    list.items.push("Android Studio");
    list.items.push("Emacs");
    list.items.push("Intellij Idea");
    list.items.push("NeoVIM");
    list.items.push("PyCharm");
    list.items.push("VSCode");
    content.body.push(@html(list));

    content.body.push(@html((Header) { 2, "Drawing Tools"}));
    list = {};
    list.items.push("GIMP");
    list.items.push("Inkscape");
    list.items.push("Krita");
    content.body.push(@html(list));

    content.body.push(@html((Header) { 2, "Operating Systems"}));
    list = {};
    list.items.push("FreeBSD");
    list.items.push("Linux");
    list.items.push("OpenBSD");
    content.body.push(@html(list));

    content.body.push(@html((Header) { 2, "Linux Distributions"}));
    list = {};
    list.items.push("Alpine Linux");
    list.items.push("Arch Linux");
    list.items.push("Artix Linux");
    list.items.push("Bedrock Linux");
    list.items.push("Chimera Linux");
    list.items.push("Debian");
    list.items.push("Gentoo");
    list.items.push("Manjaro");
    list.items.push("Mint");
    list.items.push("OpenSUSE Tumbleweed");
    list.items.push("Ubuntu");
    list.items.push("Void Linux");
    content.body.push(@html(list));

    return page;
}
