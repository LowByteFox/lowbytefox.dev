module root::gallery;

import mksite;
import layouts::base;

fn Page page()
{
    Page page = mksite::create_page("LowByteFox's Gallery");
    Main *content = base::apply(&page, 1);
    defer base::footer(&page);

    content.body.push(@html((Paragraph) { "TODO" }));

    return page;
}
