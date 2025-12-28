module root::blog::from_zig_to_c3;

import layouts::base;
import mksite;

const Blog DESC = {
    "From Zig to C3: A Journey Into Sanity",
    "/blog/from-zig-to-c3/",
    {2025, 12, 28, 21, 31}
};

fn Page page()
{
    Page page = mksite::create_page("LowByteFox's Website");
    Main *content = base::apply(&page, 1);
    defer base::footer(&page);

    Html spacer = @html((Div) {});
    @pipe(spacer, attr("class", "spacer"));

    content.body.push(spacer);
    content.body.push(@html((Header) { 1, DESC.title }));

    return page;
}
