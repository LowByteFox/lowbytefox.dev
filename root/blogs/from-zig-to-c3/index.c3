module root::blog::from_zig_to_c3;

import layouts::base;
import mksite;

import components::code;

const Blog DESC = {
    "From Zig to C3: A Journey Into Sanity?",
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

    content.body.push(@html((Paragraph) {
        `Few years ago, I have discovered a programming language called
<a href="https://ziglang.org/" target="_blank">Zig</a>, as a C programmer it
has given me the opportunity to write fast, safer code and the ability to be 
more productive. "Why not Rust?" you may ask. Well, I don't like Rust that 
much, that said I <em>won't dislike you</em> for using it! Zig was giving me 
joy, not to mention <a href="/blog/developing-portable-zig/" target="_blank">the better cross-compilation</a>
it offered, but there was <em>something</em> missing, something <em>off</em>. 
Ignoring  all the issues and breaking changes Zig has over the course of every 
release, it was C syntax... I simply kept returning to writing C because it was 
simple and intuitive for my brain to write and use...
<br><br>
And then something happened... <a href="https://tsoding.github.io/" target="_blank">Tsoding</a>
made a stream about <a href="https://c3-lang.org/" target="_blank">C3</a> 
(<a href="https://www.youtube.com/watch?v=Qzw1m7PweXs" target="_blank">VOD</a>).
At the time I was a Zig & C fanboy, I wasn't much of a fan of C3, having the need to use <code>fn</code> was a bit strange to me 
or the enforced code style: e.g. PascalCase for types, SCREAMING_SNAKE_CASE for constants, etc...
<br><br>
<em>Spoiler altert</em>: I changed my mind!`
    }));

    content.body.push(spacer);
    content.body.push(@html((Header) { 2, "Drinking C3 Capri-Sun" }));
    content.body.push(@html((Header) { 5, "(You thought I was gonna say Kool-Aid? HA! but I'm not an American)" }));

    content.body.push(@html((Paragraph) {
        `I was at the time working on a project called
<a href="https://github.com/LowByteFox/sc" target="_blank">sc</a>, which was a 
challenge for me to make a small 
<a href="https://en.wikipedia.org/wiki/Scheme_(programming_language)" target="_blank">Scheme</a>-like 
dialect, I was mostly successful, but it has UB (Undefined Behavior), and at
the time I thought, what if I give C3 a try and maybe make a proper one using 
it instead?
<br><br>
First steps were rough, especially getting familiar with the language, which 
is a bit strange considering it's C but better! I had to look at the 
<a href="https://c3-lang.org/getting-started/" target="_blank">docs</a> a lot 
(which are apparently dated!) and read the 
<a href="https://github.com/c3lang/c3c/tree/master/lib/std" target=_blank">source code</a> 
of the standard library, which went quite okay considering I have learned that 
from using Zig before!
<br><br>
During the time I was getting familiar with the language, I have recieved a ton 
of help from
<a href="https://github.com/lerno" target="_blank">Christoffer Lerno</a> himself.
I have learned about the <code>@pool</code> temporary allocator, when to use
methods and bunch more cool things I got to enjoy about the language.
`
    }));

    content.body.push(spacer);
    content.body.push(@html((Header) { 3, "The Features" }));

    content.body.push(@html((Paragraph) {
        `Now I'm going to list feature I like about the language with 
further detail.`
    }));

    content.body.push(spacer);
    content.body.push(@html((Header) { 4, "Temporary Allocator" }));
    content.body.push(@html((Paragraph) {
        `In C3, you can simplify the memory management of temporary allocations 
using the <code>@pool</code> temporary allocator macro. This macro makes memory 
management more convenient, as you don't have to manually clean up the temporary 
memory. Yes, you can do this in C, Zig, etc just fine using an
<a href="https://en.wikipedia.org/wiki/Region-based_memory_management" target="_blank"><code>Arena Allocator</code></a>,
but you also need to initialize/free the arena, costing you extra lines.
<br>
Code sample:
`
    }));

    content.body.push(code::create({
        "", "c3", 
`fn void foo()
{
    @pool()
    {
        bar();
    };
    // All temporary allocations inside of do_calculations
    // and deeper down is freed when exiting the '@pool' scope.
}`
    }));

    return page;
}
