module root::blog::making_own_nuxt;

import layouts::base;
import mksite;

import components::toc;

const Blog DESC = {
    "Making own nuxt-like framework with bun",
    "/blog/making-own-nuxt/",
    {2023, 6, 10, 20, 6},
    ORGANIC
};

fn Page page(BlogNav nav)
{
    Page page = mksite::create_page(DESC.title, DESC.path);
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
