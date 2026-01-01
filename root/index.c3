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
        `Hello! I'm LowByteFox, primarily a system level programmer, digital 
artist and a vtuber. During my free time I like working on 
<abbr title="free & open-source software">FOSS</abbr> projects and I've been doing so for the past ~5 years!
I like to do things myself so I've slowly been learning how to draw, currently I 
mostly color bases I get my hands on, but been slowly considering learning how 
to draw lines, etc. When I have time and nothing better to do I stream on 
<a href="/socials">Twitch</a>
and "code in public" as a vtuber. My goal is to write simple, user friendly & 
re-usable software to make the world a better and simpler place.
<br>
<h6>I do bite, so be careful :3</h6>`
    }));

    content.body.push(@html((Header) { 2, "Software Engineering" }));
    content.body.push(@html((Paragraph) {
        `When it comes to writing code my preferred programming languages are
C, C3 & POSIX shell scripts. I'm interested in open-source *NIX operating systems 
such as Linux, FreeBSD & OpenBSD. Through my journey I got familiar with
<a href="/technologies">many more</a> technologies than my current preference.
Things are currently a bit messy, but once sorted out, my primary git server
for repositories is <a href="/socials">Codeberg</a>, the rest can be found
on my <a href="/socials">Github</a>.`
    }));

    content.body.push(spacer);
    content.body.push(@html((Header) { 2, "Digital Art" }));
    content.body.push(@html((Paragraph) {
        `As I've mentioned, currently I'm mostly coloring bases, making small line 
edits and so on, however I've been slowly getting interested in drawing backgrounds,
considering helping myself with <a href="https://en.wikipedia.org/wiki/Minecraft" target="_blank">Minecraft</a>
so that my perspective can improve.<br>
I currently use <a href="https://krita.org" target="_blank">Krita</a> together with
<a href="https://www.xp-pen.com/product/deco-01-v3.html" target="_blank">XP-Pen Deco 01 V3</a>
 for drawing.`
    }));

    content.body.push(spacer);
    content.body.push(@html((Header) { 2, "Vtubing" }));
    content.body.push(@html((Paragraph) {
        `In my free time I stream as a PNGTuber using my own tool I've made for that
purpose called 
<a href="https://github.com/OpenPNGStudio" target="_blank">OpenPNGStudio</a>.
 One of the reasons I've made the tool was for my convenience and having control 
over it, so I could add additional features I'd like. It's currently one 
of my biggest projects yet and as of now I'm working on improving the user
experience with small improvements to the whole experience.`
    }));

    content.body.push(spacer);
    content.body.push(@html((Header) { 2, "Personal Projects" }));

    content.body.push(@html((Paragraph) {
        `List of personal projects I think you may find interesting, some are 
unfortunately no longer maintained.`
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

    content.body.push(spacer);
    content.body.push(@html((Header) { 2, "Characters" }));
    content.body.push(@html((Paragraph) {
        `Over the time, I have created many variants of my character, my current one
and most used is <a href="/art/#LowByteShork_Reference_Sheet">LowByteShork</a>, but there are many more species: 
Fox (originally), Protogen, Wyvern & NovaBeast. Except these I have also created
a Protogen called <a href="/art/#Oxy_Reference_Sheet">Oxy</a>! I have created him mostly as a mascot for 
<code>OpenPNGStudio</code> but decided to use him outside of as well!`
    }));

    return page;
}

