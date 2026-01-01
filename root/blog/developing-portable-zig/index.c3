module root::blog::developing_portable_zig;

import layouts::base;
import mksite;

import components::toc;

const Blog DESC = {
    "Writing portable Zig is easier than C",
    "/blog/developing-portable-zig/",
    {2025, 4, 10, 19, 32},
    ORGANIC
};

fn Page page(BlogNav nav)
{
    Page page = mksite::create_page(DESC.title);
    Main *content = base::apply(&page, 1);
    defer blog::footer(&page, nav);

    Toc toc;
    toc.init();
    toc.push(1, DESC.title);

    Html spacer = @html((Div) {});
    @pipe(spacer, attr("class", "spacer"));

    Html title = toc.next();
    title.attr.set("class", DESC.grade.name);
    content.body.push(title);

    content.body.push(@html((Paragraph) { "TODO, pending rewrite." }));

    return page;
}
