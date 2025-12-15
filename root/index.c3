module root;

import mksite;
import std::io;

import layouts::base;

struct Project {
    String name, url, description;
}

struct Link {
    String name, url;
}

fn Page page()
{
    Page page = mksite::create_page("LowByteFox's Website");
    Main *content = base::apply(&page, 0);
    defer base::footer(&page);

    Html spacer = @html((Div) {});
    @pipe(spacer, attr("class", "spacer"));

    content.body.push(@html((Header) { 1, "LowByteFox" }));
    content.body.push(@html((Paragraph) {
        `Hi! I'm LowByteFox, I'm (primarily) a system level programmer, digital 
artist, streamer and a vtuber. My passion is writing free (free as in freedom)
 & open-source software (FOSS) during my free time and have been doing so for
about 5 years. I happen to draw from time to time, stream on Twitch as a vtuber
(PNGtuber). I may happen to be a furry, but don't judge the book by the cover
yet. My goal is to write simple, user friendly & re-usable software to make the
world a better and simpler place.`
    }));

    content.body.push(spacer);
    content.body.push(@html((Header) { 2, "Interests" }));
    content.body.push(@html((Paragraph) {
        `My main interests root from software development, I like writing code
using C, C3 & POSIX shell scripts. I like UNIX-like operating systems such as
Linux, FreeBSD & OpenBSD. I am familiar with
<a href="/technologies">many more</a> technologies. Currently
I push my code to my <a href="/socials">Codeberg</a>, repositories that I haven't
transfered can be found on my <a href="/socials">Github</a>.`
    }));

    content.body.push(spacer);
    content.body.push(@html((Header) { 2, "Personal Projects" }));

    content.body.push(@html((Paragraph) {
        `List of personal projects, some are unfortunately no longer maintained`
    }));

    Div project_list;
    project_list.body.init(mem);

    var $projects = {
        {"OpenPNGStudio", "https://github.com/OpenPNGStudio",
            "Create & stream PNGTuber models"},
        {"Tanzanite", "https://github.com/TanzaniteLang",
            "Small, with ruby like syntax, compiled programming language"},
        {"Buchta", "https://github.com/LowByteFox/buchta",
            "Bun-First integrable build tool for frontend"},
        {"ZeonDB", "https://codeberg.org/LowByteFox/ZeonDB",
            "Multi-model, high performance, NoSQL database in C++"},
        {"Foxnit", "https://github.com/lowbyte-archives/foxnit",
            `Foxnit is a runit wrapper, something similar to systemctl,
rc-update, etc`},
        {"Senkora", "https://github.com/LowByteFox/senkora",
            `Implementation of センコラJS ( Senkora JS ) runtime -
JavaScript runtime for the modern age`},
        {"Protomalloc", "https://github.com/lowByteFox/protomalloc",
            "Custom implementation of malloc"},
        {"Protolibc", "https://github.com/lowByteFox/protolibc",
            "Protogen libc implementation based on neatlibc"},
        {"Protogens And Ram", "https://lowbytefox.itch.io/protogens-and-ram",
            `You were locked in a cottage by a toaster, escape by winning
against the toaster in a card game of "Protogens and Ram"`},
    };

    $foreach $x : $projects:
        Project $proj = (Project) $x;

        project_list.body.push(@html((StaticCustom) {"p", @html_slice(
            (Anchor) { $proj.url, $proj.name, true },
            (RawHtml) "<span>- " +++ $proj.description +++ "</span>"
        )}));
    $endforeach

    Html details = @html((Details) {
        "Projects",
        @html(project_list)
    });

    @pipe(details, attr("open", ""));
    content.body.push(details);

    return page;
}

