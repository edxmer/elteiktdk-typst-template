// =============================================================================
//  tdk.typ -- ELTE IK TDK thesis template for Typst
//
//  A port of the LaTeX class `elteiktdk` v2.1 (MIT, (c) Máté Cserép).
//  Margins, font sizes and spacing follow the original class; see README.md.
//
//  Usage:
//    #import "tdk.typ": tdk
//    #show: tdk.with(title: [...], authors: (...), ...)
// =============================================================================

// =============================================================================
//  1. Localisation
// =============================================================================

#let strings = (
  en: (
    cover: "TDK-thesis",
    author: "Author",
    authors: "Authors",
    supervisor: "Supervisor",
    supervisors: "Supervisors",
    contents: "Contents",
    bibliography: "Bibliography",
    acknowledgements: "Acknowledgements",
    // Chapter labels: "Chapter 1" / "Appendix A"
    chapter: (before: "Chapter ", after: ""),
    appendix: (before: "Appendix ", after: ""),
    // Trailing dot after section numbers: "2.1" (en) vs "2.1." (hu)
    suffix: "",
    figure: "Figure",
    table: "Table",
    code: "Code",
    algorithm: "Algorithm",
    definition: "Definition",
    theorem: "Theorem",
    remark: "Remark",
    note: "Note",
    proof: "Proof",
    figures: "List of Figures",
    tables: "List of Tables",
    codes: "List of Codes",
    algorithms: "List of Algorithms",
  ),
  hu: (
    cover: "TDK-dolgozat",
    author: "Szerző",
    authors: "Szerzők",
    supervisor: "Témavezető",
    supervisors: "Témavezetők",
    contents: "Tartalomjegyzék",
    bibliography: "Irodalomjegyzék",
    acknowledgements: "Köszönetnyilvánítás",
    chapter: (before: "", after: " fejezet"),
    appendix: (before: "", after: " függelék"),
    suffix: ".",
    figure: "Ábra",
    table: "Táblázat",
    code: "Forráskód",
    algorithm: "Algoritmus",
    definition: "Definíció",
    theorem: "Tétel",
    remark: "Emlékeztető",
    note: "Megjegyzés",
    proof: "Bizonyítás",
    figures: "Ábrajegyzék",
    tables: "Táblázatjegyzék",
    codes: "Forráskódjegyzék",
    algorithms: "Algoritmusjegyzék",
  ),
)

/// Language dependent strings of the current document.
#let strings-state = state("tdk-strings", strings.en)

/// Whether the appendix has started.
#let appendix-state = state("tdk-appendix", false)

// =============================================================================
//  2. Sizes and numbering
// =============================================================================

// Font sizes of the LaTeX class with a 12pt body text.
#let size-huge = 24.8pt   // \huge   -- chapter titles
#let size-LARGE = 20.6pt  // \LARGE  -- university name
#let size-large = 17.2pt  // \Large  -- sections
#let size-medium = 14.4pt // \large  -- subsections, title page details

/// Hierarchical numbering: "2", "2.1", "2.1.3". The trailing dot is used in
/// Hungarian only, where sections are numbered like "2.1.".
#let section-numbering(..nums) = context {
  let pattern = "1" + ".1" * (nums.pos().len() - 1) + strings-state.get().suffix
  numbering(pattern, ..nums.pos())
}

/// Numbering of the appendix: "A", "A.1", "A.1.3".
#let appendix-numbering(..nums) = context {
  let pattern = "A" + ".1" * (nums.pos().len() - 1) + strings-state.get().suffix
  numbering(pattern, ..nums.pos())
}

// =============================================================================
//  3. Theorem-like environments
// =============================================================================

#let definition-counter = counter("tdk-definition")
#let theorem-counter = counter("tdk-theorem")

/// Builds the run-in label of a theorem-like environment, e.g. "Theorem 2.".
#let theorem-label(key, counter: none, italic: false) = context {
  let name = strings-state.get().at(key)
  if counter != none { name += " " + str(counter.get().first()) }
  name += "."
  if italic { emph(name) } else { strong(name) }
}

/// An unindented block with a run-in label, like the amsthm styles.
#let theorem-block(label, italic: false, body) = block(
  above: 0.6em,
  below: 0.6em,
  {
    set par(first-line-indent: 0em)
    set text(style: if italic { "italic" } else { "normal" })
    label + [ ] + body
  },
)

/// `#definition[..]` -- numbered, upright body.
#let definition(body) = {
  definition-counter.step()
  theorem-block(theorem-label("definition", counter: definition-counter), body)
}

/// `#theorem[..]` -- numbered, italic body.
#let theorem(body) = {
  theorem-counter.step()
  theorem-block(theorem-label("theorem", counter: theorem-counter), italic: true, body)
}

/// `#remark[..]` -- unnumbered, italic label.
#let remark(body) = theorem-block(theorem-label("remark", italic: true), body)

/// `#note[..]` -- unnumbered, italic label.
#let note(body) = theorem-block(theorem-label("note", italic: true), body)

/// `#proof[..]` -- an unnumbered proof closed by an open square.
#let proof(body) = block(
  above: 0.6em,
  below: 0.6em,
  {
    set par(first-line-indent: 0em)
    emph(context strings-state.get().proof + ".") + [ ] + body + h(1fr) + $square.stroked$
  },
)

// =============================================================================
//  4. Chapters
// =============================================================================

/// A chapter-like heading without a number, like LaTeX's `\chapter*{..}`:
/// it still starts a new page and appears in the table of contents.
#let starred-chapter(title) = heading(numbering: none, outlined: true, title)

/// `#show: appendix` -- switches chapter numbering to letters (A, B, ...).
#let appendix(body) = {
  appendix-state.update(true)
  counter(heading).update(0)
  set heading(numbering: appendix-numbering)
  body
}

/// `#compact[ - a  - b ]` -- a list with narrow spacing between its items.
#let compact(body) = {
  set list(spacing: 0.8em)
  set enum(spacing: 0.8em)
  set terms(spacing: 0.8em)
  body
}

// =============================================================================
//  5. Figures, code and algorithms
// =============================================================================

/// `#fig(image(..), caption: [..])` -- a floating figure.
/// The explicit kind is what makes `#list-of-figures()` possible.
#let fig(body, caption: none) = figure(kind: "figure", body, caption: caption)

/// `#tab(table(..), caption: [..])` -- a floating table.
#let tab(body, caption: none) = figure(kind: "table", body, caption: caption)

/// `#code(caption: [..])[```py ... ```]` -- a floating source code listing.
#let code(caption: none, body) = figure(
  kind: "code",
  supplement: context strings-state.get().code,
  caption: caption,
  body,
)

/// `#algorithm(caption: [..])[ + step ... ]` -- a floating pseudocode block.
/// Write the steps as a plain `enum`, its style is set up automatically.
#let algorithm(caption: none, body) = figure(
  kind: "algorithm",
  supplement: context strings-state.get().algorithm,
  caption: caption,
  block(
    width: 100%,
    inset: (y: 0.5em),
    stroke: (top: 0.5pt, bottom: 0.5pt),
    {
      set align(left)
      set enum(numbering: "1:", indent: 1.2em, body-indent: 0.5em, spacing: 0.8em)
      body
    },
  ),
)

/// `#list-of-figures()`, `#list-of-tables()`, `#list-of-codes()`,
/// `#list-of-algorithms()` -- the back matter lists.
#let list-of-figures() = {
  starred-chapter(context strings-state.get().figures)
  outline(title: none, target: figure.where(kind: "figure"))
}

#let list-of-tables() = {
  starred-chapter(context strings-state.get().tables)
  outline(title: none, target: figure.where(kind: "table"))
}

#let list-of-codes() = {
  starred-chapter(context strings-state.get().codes)
  outline(title: none, target: figure.where(kind: "code"))
}

#let list-of-algorithms() = {
  starred-chapter(context strings-state.get().algorithms)
  outline(title: none, target: figure.where(kind: "algorithm"))
}

// =============================================================================
//  6. Title pages
// =============================================================================

/// One person on the title page: name, then the small lines below it.
#let person-column(person) = {
  text(size: size-medium, person.name)
  for line in person.at("lines", default: ()) [
    #linebreak() #line
  ]
}

/// One or two people next to each other, like on the LaTeX title page.
#let person-row(people) = {
  if people.len() == 0 { return }
  grid(
    columns: (1fr,) * people.len(),
    column-gutter: 2cm,
    ..people.enumerate().map(((i, person)) => align(
      if people.len() == 1 { center } else if i == people.len() - 1 { right } else { left },
    )[#person-column(person)]),
  )
}

// =============================================================================
//  7. The template
// =============================================================================

#let tdk(
  /// Title of the thesis.
  title: [],
  /// Authors: `(name: "Jane Doe", degree: "Computer Science MSc", period: "V. grade")`
  authors: (),
  /// Supervisors: `(name: "John Doe", affiliation: "Assistant Lecturer")`
  supervisors: (),
  /// Institution metadata, printed on the title page.
  university: [],
  faculty: [],
  department: [],
  city: none,
  year: none,
  /// Path to the university emblem, e.g. `"images/elte_cimer_szines.png"`.
  logo: none,
  /// `"en"` or `"hu"`.
  language: "en",
  /// Bibliography printed at the end of the document,
  /// e.g. `bib: bibliography("refs.bib", style: "ieee")`.
  bib: none,
  body,
) = {
  let t = strings.at(language)
  strings-state.update(t)

  // -- Global settings --------------------------------------------------------
  set document(title: title, author: authors.map(a => a.name))
  set page(
    paper: "a4",
    margin: (left: 35mm, right: 25mm, top: 25mm, bottom: 25mm),
    numbering: none,
  )
  set text(
    font: ("Times New Roman", "Libertinus Serif"),
    size: 12pt,
    lang: language,
    // Use the font's real ascender/descender as line box edges, so that the
    // vertical rhythm matches the LaTeX class.
    top-edge: "ascender",
    bottom-edge: "descender",
  )
  // 1.5 line spacing as in the LaTeX class (20.6pt between baselines), and no
  // vertical space between paragraphs -- they are separated by their indent.
  set par(leading: 0.8em, spacing: 0em, first-line-indent: (amount: 1.5em, all: true))
  set heading(numbering: section-numbering)
  set figure(numbering: "1")
  set math.equation(numbering: "1")
  set raw(tab-size: 2)

  show figure.where(kind: "figure"): set figure(supplement: context strings-state.get().figure)
  show figure.where(kind: "table"): set figure(supplement: context strings-state.get().table)
  show figure.where(kind: "algorithm"): set figure.caption(position: top, separator: [ ])
  // Lists are indented and spaced like LaTeX's itemize / enumerate / description.
  set list(indent: 1.6em, body-indent: 0.85em, spacing: 1.6em)
  set enum(indent: 1.2em, body-indent: 1.25em, spacing: 1.6em)
  set terms(indent: 0em, hanging-indent: 1.5em, spacing: 1.6em)
  show list: block.with(above: 22pt, below: 22pt)
  show enum: block.with(above: 22pt, below: 22pt)
  show terms: block.with(above: 22pt, below: 22pt)
  // Floats and display equations keep their distance from the text.
  show figure: block.with(above: 12pt, below: 12pt)
  show math.equation.where(block: true): block.with(above: 12pt, below: 12pt)
  show outline.entry.where(level: 1): set text(weight: "bold")
  show bibliography: set heading(numbering: none)
  show outline: set heading(numbering: none)

  // -- Running header ---------------------------------------------------------
  // Shows the current chapter, except on the first page of a chapter.
  set page(header: context {
    let page = here().page()
    let chapters = query(heading.where(level: 1))
    if chapters.any(it => it.location().page() == page) { return }
    let current = chapters.filter(it => it.location().page() < page).at(-1, default: none)
    if current == none { return }
    let mark = current.body
    if current.numbering != none {
      // "2. Specification and design", like LaTeX's \chaptermark. In Hungarian
      // the number already carries its trailing dot ("2.").
      let nums = counter(heading).at(current.location())
      let dot = if t.suffix == "" { "." } else { "" }
      mark = numbering(current.numbering, ..nums) + dot + " " + mark
    }
    set text(style: "italic")
    block(width: 100%, below: 1em, stroke: (bottom: 0.8pt), mark)
  })

  // -- Headings ---------------------------------------------------------------
  // A chapter always starts on a new page: its label ("Chapter 1" / "1. fejezet")
  // sits above the title, with no running header on that page.
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    block(
      above: 0pt,
      below: 44pt,
      {
        v(90pt)
        if it.numbering != none {
          let label = if appendix-state.get() { t.appendix } else { t.chapter }
          text(size: size-huge, weight: "bold")[
            #label.before#context counter(heading).display(it.numbering)#label.after
          ]
          v(40pt)
        }
        text(size: size-huge, weight: "bold", it.body)
      },
    )
  }

  // Sections, subsections and paragraphs share one style, only the size and
  // the space above them differ.
  let section-heading(it, size: 12pt, above: 33pt) = block(
    above: above,
    below: 21pt,
    text(size: size, weight: "bold")[
      #if it.numbering != none [#context counter(heading).display(it.numbering)#h(0.5em)]
      #it.body
    ],
  )
  show heading.where(level: 2): section-heading.with(size: size-large, above: 38pt)
  show heading.where(level: 3): section-heading.with(size: size-medium, above: 33pt)
  show heading.where(level: 4): section-heading

  // -- Code blocks ------------------------------------------------------------
  show raw.where(block: true): it => block(
    width: 100%,
    fill: luma(242),
    stroke: (top: 0.5pt, bottom: 0.5pt),
    inset: (x: 0.5em, y: 0.7em),
    text(size: 0.83em, it),
  )

  // -- Cover page ---------------------------------------------------------------
  set align(center)
  v(1fr)
  text(size: size-medium, weight: "bold", t.cover)
  v(1fr)
  person-row(authors)
  v(1fr)
  pagebreak()

  // -- Title page ---------------------------------------------------------------
  text(size: size-huge, weight: "bold", title)
  v(1.5cm)
  text(size: size-LARGE, upper(university))
  v(0.7cm)
  text(size: size-large, upper(faculty))
  v(0.7cm)
  text(size: size-medium, upper(department))
  v(1cm)
  if logo != none {
    image(logo, width: 30%)
    v(1cm)
  }

  text(size: size-medium, style: "italic", (if authors.len() > 1 { t.authors } else { t.author }) + ":")
  v(0.7cm)
  person-row(authors.map(a => (name: a.name, lines: (a.degree, a.period))))

  v(1.5cm)
  text(size: size-medium, style: "italic", (if supervisors.len() > 1 { t.supervisors } else { t.supervisor }) + ":")
  v(0.7cm)
  person-row(supervisors.map(s => (name: s.name, lines: (s.affiliation,))))

  v(1fr)
  text(size: size-medium, style: "italic", [#city, #year])
  pagebreak()

  // -- Table of contents --------------------------------------------------------
  set align(left)
  heading(numbering: none, outlined: false, t.contents)
  outline(title: none, depth: 3, indent: 1.5em)
  pagebreak()

  // -- Main matter --------------------------------------------------------------
  set page(numbering: "1")
  counter(page).update(1)
  body

  // -- Back matter --------------------------------------------------------------
  if bib != none {
    pagebreak(weak: true)
    bib
  }
}
