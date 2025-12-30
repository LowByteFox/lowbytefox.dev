module root::blog::from_zig_to_c3;

import layouts::base;
import mksite;

import components::code;

const Blog DESC = {
    "From Zig to C3: A Journey Into Sanity",
    "/blog/from-zig-to-c3/",
    {2025, 12, 28, 21, 31}
};

struct Project {
    String name, url, description;
}

// content.body.push(@html((Paragraph) {
//     ``
// }));

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
Ignoring all the issues, verbosity and breaking changes Zig has over the course of every 
release, it was C syntax... I simply kept returning to writing C because it was 
simple and intuitive for my brain to write and use...
<br><br>
And then something happened... <a href="https://tsoding.github.io/" target="_blank">Tsoding</a>
made a stream about <a href="https://c3-lang.org/" target="_blank">C3</a> 
(<a href="https://www.youtube.com/watch?v=Qzw1m7PweXs" target="_blank">VOD</a>).
At the time I was a Zig & C fanboy, I wasn't much of a fan of C3, having the need to use <code>fn</code> was a bit strange to me 
or the enforced code style: e.g. PascalCase for types, SCREAMING_SNAKE_CASE for constants, etc...
<br><br>
<em>Spoiler alert</em>: I changed my mind!`
    }));

    content.body.push(spacer);
    content.body.push(@html((Header) { 2, "Drinking C3 Capri-Sun" }));
    content.body.push(@html((Header) { 6, "(You thought I was gonna say Kool-Aid? HA! but I'm not an American)" }));

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
    @pool() {
        bar();
    };
    // All temporary allocations inside of bar 
    // and deeper down is freed when exiting the '@pool' scope.
}`
    }));

    content.body.push(@html((Paragraph) {
        `In the standard library functions/methods that require an
<code>Allocator</code> have prefix <code>t</code> which use the temporary 
allocator instead. In the case of such function/method missing, you can provide 
the temporary allocator using a global variable <code>tmem</code>. (For a normal
(libc) allocator you can use <code>mem</code> instead)`
    }));

    content.body.push(spacer);
    content.body.push(@html((Header) { 4, "Flexible Modules" }));
    content.body.push(@html((Paragraph) {
        `In Zig a file is a module, you cannot freely split it across files...
you kinda can, but you'll just end up nesting stuff. C3 modules feel like
C++ namespaces - a module can be extended and split across many files, heck
you can define multiple modules in a single source file!`}));

    content.body.push(spacer);
    content.body.push(@html((Header) { 5, "Module Declaration" }));
    content.body.push(@html((Paragraph) {
        `To declare you can use <code>module</code> statement e.g. <code>module foo;</code><br>
Nesting of modules is supported, <code>::</code> is used as the separator e.g.
<code>module foo::bar::baz;</code>.`
    }));

    content.body.push(spacer);
    content.body.push(@html((Header) { 5, "Module Imports" }));
    content.body.push(@html((Paragraph) {
        `To import a module, you can use the <code>import</code> statement e.g.
<code>import std::collections::list</code>. Imports always recursively import
sub-modules, which any module will automatically import other modules within
the same parent module.`
    }));

    content.body.push(code::create({
        "foo.c3", "c3", 
`module some::foo;

fn void test() {}`
    }));

    content.body.push(code::create({
        "bar.c3", "c3", 
`module bar;
import some;

// import some::foo; <- not needed, as it is a sub module to "some"
fn void test()
{
    foo::test();
    // some::foo::test() also works.
}`
    }));

    content.body.push(@html((Paragraph) {
        `What about types?<br>
Types in modules are usually imported into the global scope, this can cause
ambiguities. To prevent this issue, you can use the module path:`
    }));

    content.body.push(code::create({
        "abc.c3", "c3", 
`module abc;

struct Context {
    int a;
}`
    }));
    content.body.push(code::create({
        "de.c3", "c3", 
`module de;

struct Context {
    void *ptr;
}`
    }));
    content.body.push(code::create({
        "test.c3", "c3", 
`module test1;
import de, abc;

// Context c = {} <- ambiguous
abc::Context c = {};`
    }));

    content.body.push(spacer);
    content.body.push(@html((Header) { 5, "Module Limits" }));

    content.body.push(@html((Paragraph) {
        `Module names in C3 are limited only to lowercase characters and underscore,
and each module name can be up to 31 characters long.`
    }));

    content.body.push(spacer);
    content.body.push(@html((Header) { 4, "Flexible Types" }));
    content.body.push(@html((Paragraph) {
        `Unlike Zig, C3 allows you to define macros/methods on types from multiple 
files/modules & implement interface methods using <code>@dynamic</code> attribute.`
    }));

    content.body.push(spacer);
    content.body.push(@html((Header) { 5, "Methods" }));
    content.body.push(@html((Paragraph) {
        `Methods look exactly like functions, but are prefixed with the type name 
and is invoked using dot syntax:`
    }));

    content.body.push(code::create({
        "", "c3", 
`struct Point {
    int x;
    int y;
}

// 'Point *self' is the same as '&self'
// 'Point self' is the same as 'self'
fn void Point.add(Point *p, int x, int y) 
{
    p.x += x;
    p.y += y;
}

fn void example()
{
    Point p = { 1, 2 };

    // with struct-functions
    p.add(10, 10);

    // Also callable as:
    Point.add(&p, 10, 10);
}`
    }));

    content.body.push(@html((Paragraph) {
        `C3 offers a bit more features to functions/methods, to which I'll get to later.`
    }));

    content.body.push(spacer);
    content.body.push(@html((Header) { 4, "Interfaces" }));
    content.body.push(@html((Paragraph) {
        `Interfaces my beloved! Yes yes, Zig has tagged unions for this, but
those are usually less flexible than interfaces. Interfaces in C3 work in similar
way <code>any</code> type does, for now think of <code>any</code> as typed 
<code>void *</code>.`
    }));

    content.body.push(spacer);
    content.body.push(@html((Header) { 5, "Defining & Implementing an interface" }));
    content.body.push(@html((Paragraph) {
        `An interface can be defined like so:`
    }));

    content.body.push(code::create({
        "", "c3", 
`interface MyName {
    fn String myname();
}`
    }));

    content.body.push(@html((Paragraph) {
        `To declare a type implements an interface, add it after the type name`
    }));

    content.body.push(code::create({
        "", "c3", 
`struct Baz (MyName) {
    int x;
}

// Note how the first argument differs from the interface.
fn String Baz.myname(&self) @dynamic
{
    return "I am Baz!";
}`
    }));

    content.body.push(@html((Paragraph) {
        `This way if type <code>Baz</code> didn't implement method 
<code>myname</code> it would count as compile time error.<br>
Interfaces can be implemented on already existing types, you just won't 
get compile time checks.
<br><br>
A method must be declared <code>@dynamic</code> to implement an interface.`
    }));

    content.body.push(spacer);
    content.body.push(@html((Header) { 5, "Referring to an Interface by Pointer" }));
    content.body.push(@html((Paragraph) {
        `An interface, e.g. <code>MyName</code>, can be cast back and forth to 
<code>any</code>, but only types which implement the interface completely may 
implicitly be cast to the interface:`
    }));

    content.body.push(code::create({
        "", "c3", 
`Bob b = { 1 };
double d = 0.5;
int i = 3;
MyName a = &b;          // Valid, Bob implements MyName.
// MyName c = &d;       // Error, double does not implement MyName.
MyName c = (MyName)&d;  // Would break at runtime as double doesn't implement MyName
// MyName z = &i;       // Error, implicit conversion because int doesn't explicitly implement it.
MyName* z = (MyName)&i; // Explicit conversion works and is safe at runtime if int implements "myname"`
    }));

    content.body.push(spacer);
    content.body.push(@html((Header) { 5, "Calling Dynamic Methods" }));
    content.body.push(@html((Paragraph) {
        `Dynamic methods are called just like normal methods, you can also call 
them directly like a normal function, they just offer the benefit of being 
called from an interface:`
    }));

    content.body.push(code::create({
        "", "c3", 
`fn void whoareyou(MyName a)
{
    io::printn(a.myname());
}

// if a method on an interface is declared optional with '@optional'
fn void do_something(VeryOptional z)
{
    if (&z.do_something) {
        z.do_something(1, null);
    }
}

fn void whoareyou2(any a)
{
    // Query if the function exists
    if (!&a.myname) {
        io::printn("I don't know who I am.");
        return;
    }
    // Dynamically call the function
    io::printn(((MyName)a).myname());
}

fn void main()
{
    int i;
    double d;
    Bob bob;

    any a = &i;
    whoareyou2(a); // Prints "I am int!"
    a = &d;
    whoareyou2(a); // Prints "I don't know who I am."
    a = &bob;
    whoareyou2(a); // Prints "I am Bob!"
}`
    }));

    content.body.push(spacer);
    content.body.push(@html((Header) { 4, "Contracts" }));
    content.body.push(@html((Paragraph) {
        `Contracts are optional pre- and post-condition checks that the compiler
can use for runtime checks, optimizations, etc. Be aware the compiler may 
optimize some away, ensure you are using safe mode so they are checked during 
runtime.<br>
Code sample:`
    }));
    content.body.push(code::create({
        "", "c3", 
`<*
 @require foo > 0, foo < 1000 : "optional error msg"
*>
fn int test_foo(int foo)
{
    return foo * 10;
}

fn void main()
{
    test_foo(0); // c3c will raise an error
}

<*
 @require foo != null
 @ensure return > foo.x
*>
fn uint check_foo(Foo *foo)
{
    uint y = abs(foo.x) + 1;
    // If we had row: foo.x = 0, then this would be a runtime contract error.
    return y * abs(foo.x);
}`
    }));

    content.body.push(@html((Paragraph) {
        `You can read more about contracts
<a href="https://c3-lang.org/language-common/contracts/" target="_blank">here</a>.`
    }));

    content.body.push(spacer);
    content.body.push(@html((Header) { 4, "Honorable Mention" }));
    content.body.push(@html((Paragraph) {
        `Realizing listing all the features would make the blog post exponentially 
longer, it's already quite long. This isn't the C3 documentation %@#! it!
<br><br>
I'll simply list features I'd like to mention and provide you with a link
to the documentation page.`
    }));

    HtmlList list;
    list.items.init(mem);
    list.items.push(`Attributes (<a href="https://c3-lang.org/language-common/attributes/" target="_blank">docs</a>)`);
    list.items.push(`Generics (<a href="https://c3-lang.org/generic-programming/generics/" target="_blank">docs</a>)`);
    list.items.push(`Lambdas (<a href="https://c3-lang.org/language-fundamentals/functions/#lambdas" target="_blank">docs</a>)`);
    list.items.push(`Reflections (<a href="https://c3-lang.org/generic-programming/reflection/" target="_blank">docs</a>)`);
    list.items.push(`Simpler C Interopt (<a href="https://c3-lang.org/language-common/cinterop/" target="_blank">docs</a>)`);
    list.items.push(`Strings (<a href="https://c3-lang.org/language-common/strings/" target="_blank">docs</a>)`);
    list.items.push(`Vectors (<a href="https://c3-lang.org/language-common/vectors/" target="_blank">docs</a>)`);
    // list.items.push(` (<a href="" target="_blank">docs</a>)`);

    content.body.push(@html(list));

    content.body.push(@html((Header) { 3, "The Quirks" }));
    content.body.push(@html((Paragraph) {
        `Just like all good things, C3 isn't all sunshine and rainbows, nono
... quite a distance from it, but that's normal, not everyone likes the same things!
<br><br>
This a list of things I find strange, don't like about C3.`
    }));

    content.body.push(spacer);
    content.body.push(@html((Header) { 4, "Hello... Enums?" }));
    content.body.push(@html((Paragraph) {
        `C3 does indeed have enums, they just have been re-worked from the ground
up. Don't get me wrong, they are quite powerful, but by default they don't 
behave the same like C enums by default, for that you'll have to write a "const enum"`
    }));
    content.body.push(code::create({
        "", "c3", 
`extern fn KeyCode get_key_code();

enum KeyCode : const CInt {
    UNKNOWN = 0,
    RETURN = 13,
    ESCAPE = 27,
    BACKSPACE = 8,
    TAB = 9,
    SPACE = 32,
    EXCLAIM, // automatically incremented to 33
    QUOTEDBL,
    HASH,
}

fn void main()
{
    int a = (int) KeyCode.SPACE; // assigns 32 to a
    KeyCode b = 2; // const enums behave like typedef and will not enforce that every value has been declared beforehand
    KeyCode key = get_key_code(); // can safely interact with a C function that returns the same enum
}`
    }));
    content.body.push(@html((Paragraph) {
        `This however wasn't always the case, before we got "const enums" we either
had to rely on global constants (they have to be prefixed with module name) or 
simply deal with the extra abstraction. Just a slight warning for people who want
C style enums!
<br><br>
Here is the <a href="https://c3-lang.org/language-overview/types/#enum" target="_blank">docs</a>.`
    }));

    content.body.push(spacer);
    content.body.push(@html((Header) { 4, "Misleading naming" }));
    content.body.push(@html((Paragraph) {
        `Okay, I get it, naming is hard! And yes, this is partialy my fault coming from Zig
, but I'm sure you'll understand some of my struggles when I was learning C3.`
    }));
    
    content.body.push(spacer);
    content.body.push(@html((Header) { 5, "Optionals not being optional?" }));
    content.body.push(@html((Paragraph) {
        `<em>"Optionals are a safer alternative to returning <code>-1</code> or 
<code>null</code> from a function, when a valid value can’t be returned. An 
Optional has either a <u>result</u> or is <u>empty</u>. When an Optional is 
<u>empty</u> it has an <u>Excuse</u> explaining what happened."</em><br>...
<br>...
<br>...
<br>...
<br>...
<br>ERROR: DOES NOT COMPUTE
<br>Segmentation Fault
<br>...<br>

Hey Oxy! Can you pull up the definition of the word "optional"? Thank you!<br>
Oxy: <em>Citing Wikipedia</em><br><br>
<em>"In programming languages (especially functional programming languages) and 
type theory, an option type or maybe type is a polymorphic type that represents 
encapsulation of an optional value; e.g., it is used as the return type of 
functions which may or may not return a meaningful value when they are applied. 
It consists of a constructor which either is empty (often named <code>None</code> or <code>Nothing</code>), 
or which encapsulates the original data type A (often written Just A or Some A)."
</em>
<br><br>
So this means an optional is <em>something</em> or <em>nothing</em>.
But not in C3... it's <em>something</em> or <em>something</em>. The <u>Excuse</u>
is also a value of sorts, not the state of "nothing-ness".<br><br>
Rust has something similar to C3, it's called 
<a href="https://doc.rust-lang.org/std/result/enum.Result.html" target="_blank"><code>Result</code></a>, good name Rust!`
    }));

    content.body.push(spacer);
    content.body.push(@html((Header) { 4, "So a pipe is a file" }));

    content.body.push(@html((Paragraph) {
        `If you are just as confused as I am, that's correct! As I was implementing 
syntax highlighting for codeblocks on my website, I thought of using <code>io::read_fully</code>
function from <code>io/<em>stream.c3</em></code> which expects an object implementing 
<code>InStream</code> interface. I got stdout from spawned <code>SupProcess</code> and passed
it into the function, however I was faced with <code>io::FILE_IS_PIPE</code> fault???
<br><br>
What happened? Let me show you the source code of the function:`
    }));
    content.body.push(code::create({
        "io/stream.c3", "c3", 
`<*
 @require @is_instream(stream)
*>
macro char[]? read_fully(Allocator allocator, stream)
{
    usz len = available(stream)!;
    char* data = allocator::malloc_try(allocator, len)!;
    defer catch allocator::free(allocator, data);
    usz read = 0;
    while (read < len)
    {
        read += stream.read(data[read:len - read])!;
    }
    return data[:len];
}`
    }));

    content.body.push(@html((Paragraph) {
        `This looks mostly fine... until you realize the function <code>available</code> is 
returning size? Let's look at <code>available</code> first:`
    }));
    content.body.push(code::create({
        "io/stream.c3", "c3", 
`fn usz? available(InStream s)
{
    if (&s.available) return s.available();
    if (&s.seek)
    {
        usz curr = s.seek(0, Seek.CURSOR)!;
        usz len = s.seek(0, Seek.END)!;
        s.seek(curr, Seek.SET)!;
        return len - curr;
    }
    return 0;
}`
    }));

    content.body.push(@html((Paragraph) {
        `<em>Sigh</em>, there it is, seeking inside a stream, NOW that's not
really a problem if your input is a file... let's look at <code>stdout</code>
method of <code>SubProcess</code>:`
    }));
    content.body.push(code::create({
        "os/subprocess.c3", "c3", 
`fn File SubProcess.stdout(&self)
{
    if (!self.stdout_file) return (File){}; // Return an empty File struct
    return file::from_handle(self.stdout_file);
}`
    }));

    content.body.push(@html((Paragraph) {
        `And would you look at that? stdout is treated as a file whether it's 
an actual file or pipe!<br>
I have already <a href="https://github.com/c3lang/c3c/issues/2699" target="_blank">filed an issue</a> for this.`
    }));

    content.body.push(spacer);
    content.body.push(@html((Header) { 3, "What about the Scheme-like dialect?" }));

    content.body.push(@html((Paragraph) {
        `No worries, I have worked on it and even streamed it! You can find the 
first stream 
<a href="https://www.youtube.com/watch?v=OTBM5QWGFW0" target="_blank">here</a>. And if you're 
interested in the rest of VODs, you can find them
<a href="https://www.youtube.com/playlist?list=PLLLYvf-TM_Li9lYxEVWd-WFIA06cWaxtB" target="_blank">here</a>.
I plan on working on it some more soon!`
    }));

    content.body.push(spacer);
    content.body.push(@html((Header) { 2, "Contributions to C3" }));
    content.body.push(@html((Paragraph) {
        `As I was slowly starting to get familiar with the language, I have started 
contributing back to the language, whether it were issues or pull requests`
    }));

    content.body.push(spacer);
    content.body.push(@html((Header) { 3, "Pull Requests" }));

    content.body.push(@html((Paragraph) {
        `Just to name a few:`
    }));

    list = {};
    list.items.init(mem);
    list.items.push(`OpenBSD support (<a href="https://github.com/c3lang/c3c/pull/2310" target="_blank">here</a>)`);
    list.items.push(`FixedBlockPool (<a href="https://github.com/c3lang/c3c/pull/2360" target="_blank">here</a>)`);
    list.items.push(`Ability to compile using TinyCC (<a href="https://github.com/c3lang/c3c/pull/2459" target="_blank">here</a>)`);

    content.body.push(@html(list));

    content.body.push(@html((Paragraph) {
        `You can find full lists of issues and pull requests here:
<br>
- <a href="https://github.com/c3lang/c3c/issues?q=is%3Aissue%20author%3ALowByteFox" target="_blank">Issues</a>
<br>
- <a href="https://github.com/c3lang/c3c/pulls?q=is%3Apr%20author%3ALowByteFox" target="_blank">Pull Requests</a>
`
    }));

    content.body.push(spacer);
    content.body.push(@html((Header) { 2, "Projects in C3" }));

    Div project_list;
    project_list.body.init(mem);

    var $projects = {
        {"OpenPNGStudio", "https://github.com/OpenPNGStudio",
            "Create & stream PNGTuber models"},
        {"Schem", "https://github.com/LowByteFox/schem",
            "Scheme-like dialect written in C3"},
        {"Novacrash", "https://github.com/LowByteFox/novacrash",
            "A simple and configurable GUI panic handler for C3"},
        {"Ev", "https://github.com/OpenPNGStudio/ev",
            "Event loop implementation in C3"},
        {"Patterngen", "https://github.com/OpenPNGStudio/patterngen",
            "Generate random patterns based on seed"},
        {"Si18n", "https://github.com/OpenPNGStudio/si18n",
            "A simple, compiled internationalization library for software translations"},
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

    content.body.push(@html((Paragraph) {
        `I'm slowly progressing on these projects, most are dependencies for 
OpenPNGStudio as I'm trying to rewrite the whole project from C to C3!
<br><br>
(OpenPNGStudio was supposed to be rewritten to Zig, but I liked C3 more)`
    }));

    content.body.push(spacer);
    content.body.push(@html((Header) { 2, "Summary" }));

    content.body.push(@html((Paragraph) {
        `Zig is a good solid choice for C programmers, it's more battle
tested, has bigger and stronger community, however don't sleep on C3 either,
give it a chance! Things are rough now, but even by using it and reporting issues
you contribute to the project to make it better! C3 community may be small,
but we strive to help C3 grow, make it more known, fun and simple to use so not 
C but other developers feel at ease!<br><br>
Going to end the blog post with XKCD 989 webcomic`
    }));

    content.body.push(@html((Img) { "https://imgs.xkcd.com/comics/cryogenics.png" }));
    content.body.push(@html((Paragraph) {
        `Hope you had fun time reading, until next time!`
    }));

    return page;
}
