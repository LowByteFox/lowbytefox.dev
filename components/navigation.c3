module components::navigation;

import mksite;

fn Html create(int current_page_idx)
{
    Nav nav;
    nav.body.init_with_array(mem, {
        @html((Anchor) { "/", "Home", false }),
        @html((Anchor) { "/blog", "Blog", false }),
        @html((Anchor) { "/socials", "Socials", false }),
        @html((Anchor) { "/gallery", "Gallery", false })
    });

    if (current_page_idx != -1) {
        Html a = nav.body.get(current_page_idx);
        @pipe(a,
            attr("class", "active"),
        );

        nav.body[current_page_idx] = a;
    }

    return @html(nav);
}
