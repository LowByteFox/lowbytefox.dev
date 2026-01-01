module root::blog::from_zig_to_c3;

import layouts::base;
import mksite;

import components::code;
import components::toc;

const Blog DESC = {
    "From Zig to C3: A Journey Into Sanity",
    "/blog/from-zig-to-c3/",
    {2025, 12, 28, 21, 31},
    ORGANIC
};

struct Project {
    String name, url, description;
}

fn Page page(BlogNav nav)
{
    Page page = mksite::create_page(DESC.title);
    Main *content = base::apply(&page, 1);
    defer blog::footer(&page, nav);

    Toc toc;
    toc.init();
    toc.push(1, DESC.title);
    toc.push(2, "Drinking C3 Capri-Sun");
    toc.push(3, "The Features");
    toc.push(4, "Temporary Allocator");
    toc.push(4, "Flexible Modules");
    toc.push(5, "Module Declaration");
    toc.push(5, "Module Imports");
    toc.push(5, "Module Limits");
    toc.push(4, "Flexible Types");
    toc.push(5, "Methods");
    toc.push(4, "Interfaces");
    toc.push(5, "Defining & Implementing an interface");
    toc.push(5, "Referring to an Interface by Pointer");
    toc.push(5, "Calling Dynamic Methods");
    toc.push(4, "Contracts");
    toc.push(4, "Honorable Mention");
    toc.push(3, "The Quirks");
    toc.push(4, "Hello... C Enums?");
    toc.push(4, "Misleading naming");
    toc.push(5, "Optionals are not really Optionals?");
    toc.push(4, "So a pipe is a file");
    toc.push(3, "What about the Scheme-like dialect?");
    toc.push(2, "Contributions to C3");
    toc.push(3, "Pull Requests");
    toc.push(2, "Projects in C3");
    toc.push(2, "Summary");

    Html spacer = @html((Div) {});
    @pipe(spacer, attr("class", "spacer"));

    content.body.push(spacer);
    Html title = toc.next();
    title.attr.set("class", DESC.grade.name);
    content.body.push(title);

    content.body.push(toc.make_toc());

    content.body.push(@html((Paragraph) {
        `Few years ago, I have discovered a programming language called
<a href="https://ziglang.org/" target="_blank">Zig</a>, as a C programmer it
has given me the opportunity to write reliable, fast code while being more 
productive. "Why not Rust?" you may ask. Well, I don't like Rust that 
much, that said I <em>won't dislike you</em> for using it! Zig was giving me 
joy, not to mention <a href="/blog/developing-portable-zig/" target="_blank">the better cross-compilation</a>
it offered, but there was <em>something</em> missing, something <em>off</em>. 
Ignoring all the issues, high verbosity (e.g. when casting)
and breaking changes present in every new Zig release; it was C syntax, I simply kept 
returning to writing C because it was simple and intuitive for my brain to write...
<br><br>
And then something happened... <a href="https://tsoding.github.io/" target="_blank">Tsoding</a>
made a stream about <a href="https://c3-lang.org/" target="_blank">C3</a> 
(<a href="https://www.youtube.com/watch?v=Qzw1m7PweXs" target="_blank">VOD</a>).
At the time I was a Zig & C fanboy. C3 didn't click with me at first, having the
need to use <code>fn</code> was a bit strange to me, or the enforced code style: 
e.g. PascalCase for types, SCREAMING_SNAKE_CASE for constants, etc...
<br><br>
<em>Spoiler alert</em>: I changed my mind!`
    }));

    content.body.push(spacer);
    content.body.push(toc.next());
    content.body.push(@html((Header) { 6, "(You thought I was gonna say Kool-Aid? HA! but I'm not an American)" }));

    content.body.push(@html((Paragraph) {
        `At the time I was working on a project called
<a href="https://github.com/LowByteFox/sc" target="_blank">sc</a>, my own 
challenge to make a small 
<a href="https://en.wikipedia.org/wiki/Scheme_(programming_language)" target="_blank">Scheme</a>-like 
dialect in less than 1000 lines, I was mostly successful, however it had 
<abbr title="Undefined Behavior">UB</abbr>. Later, I thought about giving C3 a try,
why wait till it gets better? I'll use it now, possibly contribute and learn something 
new! And maybe make a new Scheme-like dialect, but not as a challenge.
So I joined C3's discord server...
<br><br>
First steps were rough, especially getting familiar with the language. It looks
like better C, but it was a whole new experience for me! I had to look at the 
<a href="https://c3-lang.org/getting-started/" target="_blank">documentation</a> a lot 
(which is apparently dated!) and read the 
<a href="https://github.com/c3lang/c3c/tree/master/lib/std" target=_blank">source code</a> 
of the standard library, which went quite okay considering I learned that 
ability from Zig!
<br><br>
During the familiarization stage of the language, I got a lot 
of help from
<a href="https://github.com/lerno" target="_blank">Christoffer Lerno</a> himself.
I have learned about the <code>@pool</code> temporary allocator, when to use
methods and bunch more cool things I get to enjoy about the language.
`
    }));

    content.body.push(spacer);
    content.body.push(toc.next());

    content.body.push(@html((Paragraph) {
        `Now I'm going to list feature I like about the language with 
further detail.`
    }));

    content.body.push(spacer);
    content.body.push(toc.next());
    content.body.push(@html((Paragraph) {
        `In C3, you can simplify the memory management of temporary allocations 
using the <code>@pool</code> temporary allocator macro. This macro makes memory 
management more convenient as you don't have to manually manage the temporary 
allocated memory. Yes, you can do this in C, Zig, etc just fine by using an
<a href="https://en.wikipedia.org/wiki/Region-based_memory_management" target="_blank"><code>Arena Allocator</code></a>.
However you also need to initialize/free the arena, costing you few extra lines.
<br><br>
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
<code>Allocator</code> use the prefix "<code>t</code>" to symbolize the usage
of the temporary allocator. If a such function/method were missing, you can provide 
the temporary allocator using the global variable "<code>tmem</code>". (For a normal
(libc) allocator you can use the global "<code>mem</code>" instead)`
    }));

    content.body.push(spacer);
    content.body.push(toc.next());
    content.body.push(@html((Paragraph) {
        `In Zig a file counts as a module, you cannot freely split it across files.
Well, yes you can, but you'll just end up nesting them. C3 modules feel kinda like
C++ namespaces - a module can be extended and split across many files, heck
you can define multiple modules in a single source file! Isn't that convenient?`}));

    content.body.push(spacer);
    content.body.push(toc.next());
    content.body.push(@html((Paragraph) {
        `To declare a module, you can use the <code>module</code> statement, e.g. 
<code>module foo;</code><br> Nesting of modules is also supported with the 
<code>::</code> separator, e.g. <code>module foo::bar::baz;</code>.`
    }));

    content.body.push(spacer);
    content.body.push(toc.next());
    content.body.push(@html((Paragraph) {
        `To import a module, you can use the <code>import</code> statement, e.g.
<code>import std::collections::list</code>. Imports are always recursive, meaning sub-modules
get imported as well:`
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

// import some::foo; <- not needed, as it is a sub-module to "some"
fn void test()
{
    foo::test();
    // some::foo::test() also works.
}`
    }));

    content.body.push(@html((Paragraph) {
        `What about types?<br>
Types in modules are usually imported into the global scope, which can cause issues
such as duplicate types. To prevent these issues, you can use the module path when
resolving the type:`
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
    content.body.push(toc.next());

    content.body.push(@html((Paragraph) {
        `Module names in C3 are limited only to lowercase characters + underscore 
and each module name can be up to 31 characters long.`
    }));

    content.body.push(spacer);
    content.body.push(toc.next());
    content.body.push(@html((Paragraph) {
        `Unlike Zig, C3 allows you to define macros/methods on types from multiple 
files/modules & implement interface methods using the <code>@dynamic</code> attribute.`
    }));

    content.body.push(spacer);
    content.body.push(toc.next());
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
    content.body.push(toc.next());
    content.body.push(@html((Paragraph) {
        `Interfaces my beloved! Yes yes, Zig has tagged unions for this, but
those are less flexible than interfaces in general. Interfaces in C3 work in similar
way <code>any</code> type does, think of <code>any</code> as typed 
<code>void *</code>.`
    }));

    content.body.push(spacer);
    content.body.push(toc.next());
    content.body.push(@html((Paragraph) {
        `An interface can be defined like so:`
    }));

    content.body.push(code::create({
        "", "c3", 
`interface MyName {
    fn String myname();
}

interface VeryOptional {
    // mark interface method as optional, making it not require the implementation 
    fn void do_something() @optional;
}`
    }));

    content.body.push(@html((Paragraph) {
        `To declare a type that implements an interface, add it after the type name:`
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
        `This way if type <code>Baz</code> didn't implement the method 
"<code>myname</code>" it would count as compile time error.<br>
Interfaces can also be implemented on already existing types, you just won't 
get the benefits of compile time checks.
<br><br>
A method must be declared with the <code>@dynamic</code> attribute
when implementing a method of an interface.`
    }));

    content.body.push(spacer);
    content.body.push(toc.next());
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
MyName z = (MyName)&i; // Explicit conversion works and is safe at runtime if int implements "myname"`
    }));

    content.body.push(spacer);
    content.body.push(toc.next());
    content.body.push(@html((Paragraph) {
        `There isn't a big difference between dynamic and normal methods,
you can call them directly like a normal function too! They just offer the 
benefit of being callable from an interface:`
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
        z.do_something();
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
    content.body.push(toc.next());
    content.body.push(@html((Paragraph) {
        `Contracts are optional pre- and post-condition checks that the compiler
can use for runtime checks, optimizations, etc. Be aware the compiler may 
optimize some away, ensure you are using safe mode of the compiler so they are 
checked during runtime.<br><br>
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
    content.body.push(toc.next());
    content.body.push(@html((Paragraph) {
        `I'm starting to realize that listing all the features would make the blog post exponentially 
longer, it's quite long already! This isn't the C3 documentation %@#* it!
<br><br>
I'll just list the features I'd like to mention and provide you with a link
to the documentation page so you can read them during your spare time:`
    }));

    HtmlList list;
    list.items.init(mem);
    list.items.push(`Attributes (<a href="https://c3-lang.org/language-common/attributes/" target="_blank">documentation</a>)`);
    list.items.push(`Generics (<a href="https://c3-lang.org/generic-programming/generics/" target="_blank">documentation</a>)`);
    list.items.push(`Lambdas (<a href="https://c3-lang.org/language-fundamentals/functions/#lambdas" target="_blank">documentation</a>)`);
    list.items.push(`Macros (<a href="https://c3-lang.org/generic-programming/macros/" target="_blank">documentation</a>)`);
    list.items.push(`Reflections (<a href="https://c3-lang.org/generic-programming/reflection/" target="_blank">documentation</a>)`);
    list.items.push(`Simpler C Interopt (<a href="https://c3-lang.org/language-common/cinterop/" target="_blank">documentation</a>)`);
    list.items.push(`Strings (<a href="https://c3-lang.org/language-common/strings/" target="_blank">documentation</a>)`);
    list.items.push(`Vectors (<a href="https://c3-lang.org/language-common/vectors/" target="_blank">documentation</a>)`);
    // list.items.push(` (<a href="" target="_blank">docs</a>)`);

    content.body.push(@html(list));

    content.body.push(toc.next());
    content.body.push(@html((Paragraph) {
        `Just like all the good things, C3 isn't all sunshine and rainbows, and 
that's okay, not everyone likes the same things, has same thoughts and so on.
<br><br>
Here is a list of things I find odd and don't like about C3:`
    }));

    content.body.push(spacer);
    content.body.push(toc.next());
    content.body.push(@html((Paragraph) {
        `C3 does have enums, they were re-worked from the ground
up. Don't get me wrong, they are indeed quite powerful, but by default they don't 
share the same behavior to C enums. To achieve such behavior, you'll have to 
write a new type of enum called a "const enum":`
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
had to rely on global constants or simply deal with the extra added abstraction.
Just a slight warning for people who want C style enums!
<br><br>
Here is the <a href="https://c3-lang.org/language-overview/types/#enum" target="_blank">documentation</a>
 page to learn more about enums.`
    }));

    content.body.push(spacer);
    content.body.push(toc.next());
    content.body.push(@html((Paragraph) {
        `Okay, I get it, naming is hard! And yes, this is also likely my fault coming from Zig
and a bit of Rust. I'm sure you'll understand some of my struggles when you decide to learn C3 too.`
    }));
    
    content.body.push(spacer);
    content.body.push(toc.next());
    content.body.push(@html((Paragraph) {
        `Citing the documentation: <em>"Optionals are a safer alternative to returning <code>-1</code> or 
<code>null</code> from a function, when a valid value can’t be returned. An 
Optional has either a <u>result</u> or is <u>empty</u>. When an Optional is 
<u>empty</u> it has an <u>Excuse</u> explaining what happened."</em><br>...
<br>...
<br>...
<br>...
<br>...
<br>ERROR: Does Not Compute
<br>Segmentation Fault
<br>...<br>

Hey Oxy! Can you pull up the definition of the word "optional" in programming context 
for me? Thank you!<br>`
    }));
    content.body.push(@html((Figure) {
        "/oxy_peek.png",
        `Citing Wikipedia: <em>"In programming languages (especially functional 
programming languages) and  type theory, an option type or maybe type is a 
polymorphic type that represents encapsulation of an optional value; e.g., it 
is used as the return type of  functions which may or may not return a 
meaningful value when they are applied. It consists of a constructor which 
either is empty (often named <code>None</code> or <code>Nothing</code>), or 
which encapsulates the original data type <code>A</code> (often written <code>Just 
A</code> or <code>Some A</code>)."
</em>`
    }));
    content.body.push(@html((Paragraph) {
        `
So this means an optional is either <em>something</em> or <em>nothing</em>.
But that's not a case in C3... it's <em>something</em> or <em>something</em>.
The <u>Excuse</u> is also kinda a value, not the state of "nothing-ness".<br><br>
Rust has something similar to C3, it's called 
<a href="https://doc.rust-lang.org/std/result/enum.Result.html" target="_blank"><code>Result</code></a>, good name Rust!`
    }));

    content.body.push(spacer);
    content.body.push(toc.next());

    content.body.push(@html((Paragraph) {
        `If you are just as confused as I am, that's correct! As I was implementing 
syntax highlighting for codeblocks on my website, I thought of using <code>io::read_fully</code>
function from <code>io/stream.c3</code> which expects an object implementing the
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
returning size? Let's look at the <code>available</code> function:`
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
really an issue if your input stream is a file... not really a case for a pipe,
then let's have a look at <code>stdout</code> method of <code>SubProcess</code>:`
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
an actual file or a pipe!<br>
I have already <a href="https://github.com/c3lang/c3c/issues/2699" target="_blank">filed an issue</a> for this.`
    }));

    content.body.push(spacer);
    content.body.push(toc.next());

    content.body.push(@html((Paragraph) {
        `I have worked on it and even streamed the progress of it! You can find the 
first stream 
<a href="https://www.youtube.com/watch?v=OTBM5QWGFW0" target="_blank">here</a>. And if you're 
interested in the rest of the VODs, you can find them all
<a href="https://www.youtube.com/playlist?list=PLLLYvf-TM_Li9lYxEVWd-WFIA06cWaxtB" target="_blank">here</a>.
I plan on working on it and streaming some more soon!`
    }));

    content.body.push(spacer);
    content.body.push(toc.next());
    content.body.push(@html((Paragraph) {
        `As I was starting to get familiar with the language, I have started 
contributing back, whether it were issues, pull requests, projects or sharing
the good word.`
    }));

    content.body.push(spacer);
    content.body.push(toc.next());

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
    content.body.push(toc.next());

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
        {"lowbytefox.dev", "https://github.com/LowByteFox/lowbytefox.dev",
            "This website is written in C3"},
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
    content.body.push(toc.next());

    content.body.push(@html((Paragraph) {
        `Zig is a solid choice for C programmers as it's more battle
tested, has bigger and stronger community, however don't sleep on C3 either,
give it a chance! Things are rough now, but by using it and reporting issues
you contribute to the project and help it become better! C3 community may be small,
but we strive to help C3 grow, make it more known, fun and simple to use.<br>
<br>
Sources:<br>
- <a href="https://c3-lang.org/getting-started/" target="_blank">C3 Documentation</a><br>
- <a href="https://en.wikipedia.org/wiki/Option_type" target="_blank">Wikipedia</a><br>`
    }));

    content.body.push(@html((Figure) {
        "https://imgs.xkcd.com/comics/cryogenics.png",
        "XKCD 989"
    }));

    content.body.push(@html((Paragraph) {
        `Hope you had fun time reading, until next time!`
    }));

    return page;
}
