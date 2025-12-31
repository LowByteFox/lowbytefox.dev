module root::socials;

import mksite;

import layouts::base;

fn Page page()
{
    Page page = mksite::create_page("LowByteFox's Socials");
    Main *content = base::apply(&page, 2);
    defer base::footer(&page);

    Html spacer = @html((Div) {});
    @pipe(spacer, attr("class", "spacer"));

    content.body.push(@html((Header) { 1, "Discord" }));
    content.body.push(@html((Paragraph) {
        `I primarily use Discord as the main way of communication, my username
is “lowbytefox”. Keep in mind that Discord may reject friend requests if you
aren’t in a mutual server with me.`
    }));

    content.body.push(spacer);
    Html hlinks = @html((Header) { 2, "Quick Links" });
    @pipe(hlinks, attr("id", "links"));
    content.body.push(hlinks);

    HtmlList links = {};
    links.items.init(mem);

    var $links = {
        {"Codeberg", "https://codeberg.org/LowByteFox/"},
        {"Github", "https://github.com/LowByteFox"},
        {"Twitch", "https://www.twitch.tv/lowbytefox"},
        {"Bluesky", "https://bsky.app/profile/lowbytefox.dev"},
        {"X", "https://x.com/LowByteFox"},
        {"Itch.io", "https://lowbytefox.itch.io/"},
        {"FurAffinity", "https://www.furaffinity.net/user/lowbytefox"},
    };

    $foreach $x : $links:
        Link $link = (Link) $x;

        links.items.push(@html_str(@html(
            (Anchor) { $link.url, $link.name, true }
        )));
    $endforeach

    content.body.push(@html(links)); 
    return page;
}
