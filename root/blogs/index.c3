module root::blog;

import mksite;

import layouts::base;
import components::blog_grades;

fn Page page()
{
    Page page = mksite::create_page("LowByteFox's Website");
    Main *content = base::apply(&page, 1);
    defer base::footer(&page);

    Html spacer = @html((Div) {});
    @pipe(spacer, attr("class", "spacer"));

    content.body.push(spacer);
    content.body.push(@html((Header) { 1, "Blog Articles" }));

    content.body.push(@html((Paragraph) {
        `Here you can find all the blogs I have wrote so far, before you begin
reading, I want you to read next part.`
    }));

    content.body.push(spacer);
    content.body.push(@html((Header) { 2, "\"Grading\" system" }));
    content.body.push(@html((Paragraph) {
        `For the sake of transparency, I have decided to create this "grading"
system, each blog has been graded for you, so you can decided which one to
read based on your personal opinion.`
    }));

    content.body.push(blog_grades::create());

    return page;
}
