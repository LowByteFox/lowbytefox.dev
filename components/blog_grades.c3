module components::blog_grades;

import mksite;

struct Grade {
    String type, name, desc;
}

fn Html create()
{
    Div div;
    div.body.init(mem);

    var $grades = {
        {"Organic", "/blog_organic.png", `Blog fully written by me, using only my brain,
may contain errors.<br><br>
(I'll attempt to write these most of the time)`},
        {"Checked", "/blog_checked.png", `Blog was checked using automated tools and
other sources for errors, improvements, etc. Sources will be stated at the end 
of each blog, and written without the use of a LLM.<br><br>
(Knowing myself, this one will be the most frequent)`},
        {"Assisted", "/blog_assisted.png", `Blog was <em>mostly</em> written by me,
however expect some assistance from a LLM, what LLM was used will be stated.
<br><br>(I'll keep these at minimum frequency)`},
        {"Slop", "/blog_slop.png", `Do NOT believe the blog, mostly written by a LLM,
will contain common known issues of LLMs.<br><br>

(I will NOT write these, maybe for April Fools)`}
    };

    $foreach $x : $grades:
        Grade $grad = (Grade) $x;
        @pool() {
            Div tmp;
            tmp.body.init(mem);

            Html type = @html((Paragraph) { $grad.type });
            String temp = $grad.type;
            type.attr.set("class", temp.to_lower_copy(mksite::arena));

            tmp.body.push(type);
            tmp.body.push(@html((Img) { $grad.name }));
            tmp.body.push(@html((Paragraph) { $grad.desc }));

            div.body.push(@html(tmp));
        };
    $endforeach

    Html div_html = @html(div);
    @pipe(
        div_html,
        attr("class", "blog_grades")
    );

    return @html((Details) { "Details", div_html });
}
