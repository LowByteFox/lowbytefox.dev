#!/bin/env bun
/* lang code_path */

if (Bun.argv.length != 4) {
    console.log("./shiki/highlight.ts LANG CODE_PATH");
    process.exit(1);
}

import { createHighlighter } from "shiki"

const carbonfox = JSON.parse(await (Bun.file("./shiki/carbonfox-dark-theme.json")).text());
const c3 = JSON.parse(await (Bun.file("./shiki/c3-grammar.json")).text());

const highlighter = await createHighlighter({
    langs: ["c", c3, "zig"],
    themes: [carbonfox]
});

const lang = Bun.argv[2];

const code = await (Bun.file(Bun.argv[3])).text();

const html = highlighter.codeToHtml(code, {
  lang: lang,
  theme: "Carbonfox"
});

console.log(html);
