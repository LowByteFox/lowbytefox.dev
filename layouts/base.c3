module layouts::base;

import mksite;
import components::navigation;

fn Main *apply(Page *page, int page_idx)
{
    page.head.push(@html((HLink) {
        .type = "text/css",
        .rel = "stylesheet",
        .href = "/fonts.css"
    }));

    page.head.push(@html((HLink) {
        .type = "text/css",
        .rel = "stylesheet",
        .href = "/style.css"
    }));

    Html banner = @html((Img) { "/eepy_shark.png" });

    @pipe(
        banner,
        attr("class", "banner")
    );

    page.body.push(banner);

    Div div;
    Main main;
    div.body.init(mem);
    main.body.init(mem);

    div.body.push(navigation::create(page_idx));
    div.body.push(@html(main));

    Html div_html = @html(div);
    @pipe(
        div_html,
        attr("class", "content")
    );

    page.body.push(div_html);

    return (Main*) div.body.get_ref(1).element;
}

fn void footer(Page *page)
{
    Div *div = (Div*) page.body.get_ref(1).element;

    div.body.push(@html((RawHtml) "<hr>"));
    div.body.push(@html((Paragraph) {
    `Copyright &copy; 2025 LowByteFox, all rights reserved. All opinions on
this website are my own, they do not represent anyone in the past, present nor
the future.`
    }));
}
