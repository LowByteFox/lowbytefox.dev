module components::toc;

import mksite;

import std::collections::list;
import std::ascii;

struct Toc {
    List{Header} headers;
    usz iter;
}

fn void Toc.init(&self)
{
    self.headers.init(mem);
    self.iter = 0;
}

fn void Toc.push(&self, int size, String text)
{
    self.headers.push({ size, text });
}

fn Html Toc.next(&self)
{
    if (self.iter == self.headers.len()) return @html((Paragraph) {"!!! NO MORE HEADERS"});

    Header header = self.headers[self.iter++];

    Html head = @html(header);
    head.attr.set("id", to_id(header.text));

    return head;
}

fn Html Toc.make_toc(&self)
{
    Div list;
    list.body.init(mem);

    foreach (&header : self.headers) {
        String id = to_id(header.text);

        list.body.push(@html((StaticCustom) {"p", @html_slice(
            (RawHtml) "<span>- </span>",
            (Anchor) { string::format(mem, "#%s", id), header.text, false },
        )}));
    }

    Html details = @html((Details) {
        "Table of Contents",
        @html(list)
    });

    @pipe(&details, attr("class", "toc"));

    return details;
}

fn String to_id(String in) @local
{
    String res = in.copy(mem);

    foreach (&c : res) {
        if (!ascii::is_alnum(*c)) *c = '_';
    }

    return res;
}
