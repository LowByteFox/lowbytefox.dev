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

    Html banner = @html((Img) { "/banner.avif" });

    @pipe(
        banner,
        attr("class", "banner"),
        attr("alt", "banner"),
        attr("width", "845"),
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

struct Button {
    String path, url;
}

fn void footer(Page *page)
{
    Div *div = (Div*) page.body.get_ref(1).element;

    var $btns = {
        {"/buttons/lowbyteshork.png", "https://lowbytefox.dev"},
        {"/buttons/ry_88x31.png", "https://ry.cd-rom.net"},
        {"/buttons/sudo.png", "https://sudo.pink"},
        {"/buttons/vcss.png", "https://jigsaw.w3.org/css-validator/check/referer"},
        {"/buttons/ritchie.gif", "https://en.wikipedia.org/wiki/Dennis_Ritchie"},
        {"/buttons/browser.gif", ""},
        {"/buttons/voidlinux.gif", "https://voidlinux.org"},
        {"/buttons/linux_now.gif", "https://kernel.org"},
        {"/buttons/neovim.png", "https://neovim.io"},
        {"/buttons/madewithc3.png", "https://c3-lang.org/"},
        {"/buttons/html_learn_it_today.gif", ""},
        {"/buttons/css_is_awesome.gif", ""},
        {"/buttons/javascript.gif", ""},
        {"/buttons/roly-saynotoweb3.gif", "https://yesterweb.org/no-to-web3"},
        {"/buttons/twopaws.png", ""},
        {"/buttons/toe_beans_now.gif", ""},
    };

    Div buttons;
    buttons.body.init(mem);

    $foreach $b : $btns:
        Button $btn = (Button) $b;

        $if $btn.url.len > 0:
            buttons.body.push(@html(
                (RawHtml) `<a href="` +++ $btn.url +++ `" target="_blank">` +++
                `<img width="88" alt="button" height="31" src="` +++ $btn.path +++ `"></a>`
            ));
        $else
            buttons.body.push(@html(
                (RawHtml) `<img width="88" alt="button" height="31" src="` +++ $btn.path +++ `">`
            ));
        $endif
    $endforeach

    Html btns = @html(buttons);

    @pipe(&btns, attr("class", "web_buttons"));

    div.body.push(@html((RawHtml) "<hr>"));
    div.body.push(btns);

    div.body.push(@html((Paragraph) {
    `Copyright &copy; 2025 LowByteFox, all rights reserved. All opinions on
this website are my own, they do not represent anyone in the past, present nor
the future.`
    }));
}
