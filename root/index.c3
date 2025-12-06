module root;

import mksite;

import layouts::base;

fn Page page()
{
    Page page = mksite::create_page("LowByteFox's Website");
    Main *content = base::apply(&page, 0);
    defer base::footer(&page);

    Html spacer = @html((Div) {});
    @pipe(spacer, attr("class", "spacer"));

    content.body.push(spacer);
    content.body.push(@html((Header) { 1, "LowByteFox"}));
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
    content.body.push(@html((Header) { 2, "Interests"}));
    content.body.push(@html((Paragraph) {
        `My main interests root from software development, I like writing code
using C, C3 & POSIX shell scripts. I like UNIX-like operating systems such as
Linux, FreeBSD & OpenBSD. I am familiar with
<a href="/technologies">many more</a> technologies. Currently
I push my code to my <a href="#links">Codeberg</a>, repositories that I haven't
transfered can be found on my <a href="#links">Github</a>.`
    }));

    return page;
}

