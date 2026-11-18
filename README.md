# Typst port of the ELTE IK TDK thesis template

A [Typst](https://typst.app) template for TDK papers of the ELTE Faculty of
Informatics, ported from the LaTeX class
[`elteiktdk`](https://github.com/mcserep/elteiktdk) v2.1 (MIT, © Máté Cserép).
Cover page, title page, margins, font sizes and vertical spacing follow the
original class.

| File | Purpose |
| --- | --- |
| `tdk.typ` | the template itself (everything is in this file) |
| `main.typ` | example document exercising every feature |
| `refs.bib` | example bibliography |
| `images/elte_cimer_szines.png` | ELTE emblem used on the title page |

Compile the example with:

```sh
typst compile main.typ      # or: typst watch main.typ
```

## Typography

Body text is set the way the LaTeX class sets it: Times, 12pt, 1.5 line
spacing, justified, and paragraphs are separated by their first-line indent
only -- there is no extra vertical space between them. The space around
headings, lists, floats and their captions, displayed equations, theorem-like
blocks, code listings and bibliography entries is calibrated against the LaTeX
output, so both templates paginate in the same rhythm. Do not add
`par(spacing: ...)` on top of it: it shifts all of those gaps.

## Getting started

```typst
#import "tdk.typ": tdk
#import "tdk.typ": appendix, starred-chapter, compact
#import "tdk.typ": definition, theorem, remark, note, proof
#import "tdk.typ": fig, tab, code, algorithm
#import "tdk.typ": list-of-figures, list-of-tables, list-of-codes, list-of-algorithms

#show: tdk.with(
  title: [Title of the thesis],
  authors: (
    (name: "Jane Doe", degree: "Computer Science MSc", period: "V. grade"),
  ),
  supervisors: (
    (name: "John Doe", affiliation: "Assistant Lecturer"),
  ),
  university: "Eötvös Loránd University",
  faculty: "Faculty of Informatics",
  department: "Dept. of Software Technology and Methodology",
  city: "Budapest",
  year: 2024,
  logo: "images/elte_cimer_szines.png",
  language: "en",                          // or "hu"
  bib: bibliography("refs.bib", style: "ieee"),
)

= Introduction

Text with a citation @dahl1972structured and a footnote.#footnote[Like this.]

== A section

- A list
- of items

#compact[
  + A list with narrow spacing,
  + like LaTeX's `compactenum`.
]
```

The `#show: tdk.with(..)` call prints the cover page, the title page and the
table of contents; the rest of the file is the thesis itself.

## Content

| What | How |
| --- | --- |
| Chapter | `= Title` (starts a new page, numbered "Chapter 1") |
| Unnumbered chapter | `#starred-chapter[Title]` |
| Section / subsection | `== Title` / `=== Title` |
| Appendix | `#show: appendix` before the appendix chapters |
| Figure | `#fig(image("a.png"), caption: [..]) <fig:a>`, see `@fig:a` |
| Table | `#tab(table(..), caption: [..]) <tab:a>`, see `@tab:a` |
| Source code | `#code(caption: [..])[```py .. ```]`, see `@code:a` |
| Pseudocode | `#algorithm(caption: [..])[ + step ... ]`, see `@alg:a` |
| Description list | `/ Term: explanation` (bold run-in term, hanging indent) |
| Theorem-like | `#definition[..]`, `#theorem[..]`, `#proof[..]`, `#remark[..]`, `#note[..]` |
| Numbered equation | `$ e^(i pi) + 1 = 0 $ <eq:euler>`, see `@eq:euler` |
| Back matter lists | `#list-of-figures()`, `#list-of-tables()`, `#list-of-codes()`, `#list-of-algorithms()` |
| Acknowledgements | `#starred-chapter[Acknowledgements]` |

`#fig`, `#tab`, `#code` and `#algorithm` are thin wrappers around `figure` that
set the figure *kind*, which is what makes the back matter lists possible. The
localised name ("Figure", "Ábra", "Code", "Forráskód", ...) is applied
automatically.

The `bib:` argument prints the bibliography on the last page of the document.
If you need it earlier, drop `bib:` and write `#bibliography("refs.bib",
style: "ieee")` at the place you want it.

## Hungarian documents

Set `language: "hu"` in the template call. Everything else is translated by the
template: chapter labels become "1. fejezet", sections are numbered "2.1.",
figure/table/code names, theorem environments, the contents, the bibliography
and the back matter lists are all localised.

## Differences from the LaTeX class

These are deliberate; everything else is reproduced 1:1.

- **The page margins are symmetric** (30 mm on both sides), so that the text
  block and the title pages are centred on the paper. The LaTeX class uses a
  35 mm binding margin on the left and 25 mm on the right; both give the same
  150 mm text width. Change the `margin` in `tdk.typ` if you need the binding
  edge.
- **Page numbering** starts at 1 on the first page of the main matter. The
  LaTeX class happens to start it two pages earlier (the table of contents page
  counts as page 1), which is not a requirement of the formal regulations.
- **Floating objects and equations are numbered sequentially** ("Figure 1",
  "Table 2", "Code 3", "(4)") instead of per chapter ("Figure 2.1"). In Typst a
  chapter-dependent number would be re-evaluated at the position of the
  reference or of the list of figures, which makes such numbers unreliable.
- **Source code listings have no line numbers**; Typst's built-in syntax
  highlighting would be lost when re-drawing the lines for numbering.
- **Small caps** are not available in Times New Roman, so the institution name
  on the title page is typeset in capitals.
- **Marginal `\todo` notes** and the nomenclature (list of symbols) are not
  part of this template; see the `marginalia` and `nomencl` Typst packages if
  you need them.
- The class options `parspace`, `noindent`, `nohyp` and `twoside` are not
  implemented — the template always uses the default (one-sided, indented,
  hyphenated, no space between paragraphs).

## Licence

The LaTeX original is MIT licensed, © 2013–2024 Máté Cserép. This port keeps
the same licence and the same look.
