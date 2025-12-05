module mksite;

import std::collections::map;
import std::io;

typedef HtmlAttr (Printable) = inline HashMap{String,String};

fn usz? HtmlAttr.to_format(&self, Formatter* formatter) @dynamic
{
    usz res = 0;

    self.@each(;String key, String val) {
        if (res == 0) {
            res += formatter.printf("%s=\"%s\"", key, val)!;
        } else {
            res += formatter.printf(" %s=\"%s\"", key, val)!;
        }
    };

    return res;
}

interface HtmlElement {
    fn usz? to_html(HtmlAttr attr, Formatter *formatter);
}

struct Html {
    HtmlAttr attr;
    HtmlElement element;
}

<*
@require $defined(HtmlElement test = &&#val) : "Needs to implement HtmlElement"
*>
macro Html @html(#val) @builtin
{
    Html html;
    html.attr.init(mem);
    html.element = @aclone(#val);

    return html;
}

fn usz? Html.to_format(&self, Formatter* formatter) @dynamic =>
    self.element.to_html(self.attr, formatter);

macro @pipe(#value, ...) @builtin
{
    var $x = 0;
    $for var $i = 0; $i < $vacount; $i++:
        $vaconst[$i](&#value.attr);
    $endfor
}

macro attr(String $key, String $value) @builtin =>
    fn void(HtmlAttr *a) => a.set($key, $value);

macro @aclone(value) => allocator::clone(mksite::arena, value);


/* HTML Tags */

import std::collections::list;

struct Page (HtmlElement) {
    String title;
    List{Html} head;
    List{Html} body;
}

fn usz? Page.to_html(&self, HtmlAttr attr, Formatter *formatter) @dynamic
{
    usz res = 0;

    res += formatter.printf(`<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>%s</title>
`, self.title)!;
    
    foreach (h : self.head) {
        res += formatter.printf("        %s\n", h)!;
    }

    res += formatter.printf(`    </head>
    <body>
`)!;

    foreach (h : self.body) {
        res += formatter.printf("       %s\n", h)!;
    }

    res += formatter.printf(`    </body>
</html>`)!;

    return res;
}

fn Page create_page(String title)
{
    Page p;
    p.title = title;
    p.head.init(mem);
    p.body.init(mem);

    return p;
}

struct HLink (HtmlElement) {
    String type, rel, href;
}

fn usz? HLink.to_html(&self, HtmlAttr attr, Formatter *formatter) @dynamic =>
    formatter.printf("<link type=\"%s\" rel=\"%s\" href=\"%s\" %s >",
        self.type, self.rel, self.href, attr);

struct Nav (HtmlElement) {
    List{Html} body;
}

fn usz? Nav.to_html(&self, HtmlAttr attr, Formatter *formatter) @dynamic
{
    usz res = 0;

    res += formatter.printf("<nav %s >\n", attr)!;

    foreach (h : self.body) {
        res += formatter.printf("%s", h)!;
    }

    res += formatter.printf("</nav>")!;

    return res;
}

struct Paragraph (HtmlElement) {
    String text;
}

fn usz? Paragraph.to_html(&self, HtmlAttr attr, Formatter *formatter) @dynamic
    => formatter.printf("<p %s>%s</p>", attr, self.text);

struct Img (HtmlElement) {
    String src;
}

fn usz? Img.to_html(&self, HtmlAttr attr, Formatter *formatter) @dynamic
    => formatter.printf("<img src=\"%s\" %s />", self.src, attr);

struct Anchor (HtmlElement) {
    String href;
    String body;
    bool open_blank;
}

fn usz? Anchor.to_html(&self, HtmlAttr attr, Formatter *formatter) @dynamic
    => formatter.printf("<a href=\"%s\" %s %s >%s</a>",
        self.href, self.open_blank ? "target=\"_blank\"" : "", attr,
        self.body);

struct Div (HtmlElement) {
    List{Html} body;
}

fn usz? Div.to_html(&self, HtmlAttr attr, Formatter *formatter) @dynamic
{
    usz res = 0;

    res += formatter.printf("<div %s >\n", attr)!;

    foreach (h : self.body) {
        res += formatter.printf("%s\n", h)!;
    }

    res += formatter.printf("</div>")!;

    return res;
}

struct Main (HtmlElement) {
    List{Html} body;
}

fn usz? Main.to_html(&self, HtmlAttr attr, Formatter *formatter) @dynamic
{
    usz res = 0;

    res += formatter.printf("<main>\n", attr)!;

    foreach (h : self.body) {
        res += formatter.printf("%s\n", h)!;
    }

    res += formatter.printf("</main>")!;

    return res;
}

struct Header (HtmlElement) {
    int size;
    String text;
}

fn usz? Header.to_html(&self, HtmlAttr attr, Formatter *formatter) @dynamic
    => formatter.printf("<h%d %s>%s</h%d>", self.size, attr, self.text,
        self.size);
