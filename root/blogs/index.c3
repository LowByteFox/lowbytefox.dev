module root::blog;

import mksite;
import std::sort, std::io;

import std::collections::list, std::collections::map;
import std::time::datetime;

import layouts::base;
import components::blog_grades;

struct Date {
    int year, month, day, hour, minute;
}

enum Grade : (String name) {
    ORGANIC = "organic",
    CHECKED = "checked",
    ASSISTED = "assisted",
    SLOP = "slop"
}

struct Blog {
    String title, path;
    Date date;
    Grade grade;
}

struct BlogNav {
    String prev, prev_title;
    String next, next_title;
}

alias PageGen = fn Page(BlogNav nav);

struct AutoBlog {
    inline Blog blog;
    PageGen call;
}

AutoBlog[] blogs = {
    { blog::from_zig_to_c3::DESC, &blog::from_zig_to_c3::page },
    { blog::developing_portable_zig::DESC, &blog::developing_portable_zig::page },
    { blog::making_own_nuxt::DESC, &blog::making_own_nuxt::page },
};

fn bool Blog.less(&self, Blog other)
{
DateTime a = datetime::from_date(self.date.year, (Month) self.date.month - 1,
        self.date.day, self.date.hour, self.date.minute);
    DateTime b = datetime::from_date(other.date.year,
        (Month) other.date.month - 1, other.date.day, other.date.hour,
        other.date.minute);
    return a.after(b);
}

fn Page page()
{
    sort::quicksort(blogs);

    Page page = mksite::create_page("LowByteFox's Blog");
    Main *content = base::apply(&page, 1);
    defer base::footer(&page);

    Html spacer = @html((Div) {});
    @pipe(spacer, attr("class", "spacer"));

    content.body.push(spacer);
    content.body.push(@html((Header) { 1, "Blog" }));

    content.body.push(@html((Paragraph) {
        `Here you can find all the blogs I have wrote so far, before you begin
reading, I want you to read next part.`
    }));

    content.body.push(spacer);
    content.body.push(@html((Header) { 2, "\"Grading\" system" }));
    content.body.push(@html((Paragraph) {
        `For the sake of transparency, I have decided to create this "grading"
system, each blog has been graded. You can decided which one to read based on
your personal opinions.`
    }));

    content.body.push(blog_grades::create());

    List{Html} tmp;
    tmp.init(mem);
    defer tmp.free();

    foreach (&blog : blogs) {
        String datefmt = string::format(mksite::arena, "%02d:%02d %02d/%02d/%04d",
            blog.date.hour, blog.date.minute, blog.date.day, blog.date.month,
            blog.date.year);

        Html item = @html((StaticCustom) {"li", @html_slice(
            (RawHtml) string::format(mksite::arena,
                `<span class="date">%s</span>`, datefmt),
            (RawHtml) "<span> - </span>",
            (Anchor) {blog.path, blog.title, false},
        )});

        item.attr.set("class", blog.grade.name);

        tmp.push(item);
    }

    content.body.push(spacer);
    content.body.push(@html((Header) { 2, "Articles" }));

    Html ul = @html((StaticCustom) {"ul",
        tmp.to_array(mksite::arena)
    });

    @pipe(ul, attr("class", "blogs"));

    content.body.push(ul);

    return page;
}

fn void populate(HashMap{String, Page} *pages)
{
    foreach (i, &blog : blogs) {
        @pool() {
            BlogNav nav = { "", "", "", "" };
            if (i > 0) {
                Blog b = blogs[i - 1];
                nav.next = b.path;
                nav.next_title = b.title;
            }

            if (i + 1 < blogs.len) {
                Blog b = blogs[i + 1];
                nav.prev = b.path;
                nav.prev_title = b.title;
            }

            pages.set(string::tformat("%sindex.html", blog.path[1..]),
                blog.call(nav));
        };
    }
}

fn void footer(Page *page, BlogNav nav)
{
    Div *div = (Div*) page.body.get_ref(1).element;

    Div navigation;
    navigation.body.init(mem);
    if (nav.prev.len > 0) {
        Html a = @html((Anchor) {
            nav.prev,
            string::format(mem, "<<< %s", nav.prev_title),
            false
        });
        a.attr.set("title", nav.prev_title);

        navigation.body.push(a);
    } else {
        navigation.body.push(@html((RawHtml) "<div></div>"));
    }

    if (nav.next.len > 0) {
        Html a = @html((Anchor) {
            nav.next,
            string::format(mem, "<<< %s", nav.next_title),
            false
        });

        @pipe(&a, attr("class", "next"));
        a.attr.set("title", nav.next_title);

        navigation.body.push(a);
    }

    if (nav.prev.len > 0 || nav.next.len > 0) {
        Html nav_html = @html(navigation);
        @pipe(&nav_html, attr("class", "blog_navigation"));
        div.body.push(nav_html);
    }

    base::footer(page);
}
