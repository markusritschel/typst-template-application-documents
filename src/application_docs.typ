// src/application_docs.typ
// Template for a job application package
// Pages: Title Page | Cover Letter | CV (2-col + sidebar) | Certificates

#import "@preview/cheq:0.3.0": checklist
#import "@preview/fontawesome:0.6.0": *
#import "@preview/pergamon:0.8.0": *
#import "@preview/citegeist:0.2.2": load-bibliography as parse-bib
#import "rendering.typ": *

// ─── Translations ──────────────────────────────────────────────────────────────

#let _translations = yaml("translate.yml")
#let tr(key, lang) = _translations.at(key).at(lang)

// ─── Theme defaults ────────────────────────────────────────────────────────────

#let bm-defaults = (
  accent: rgb("#3b7dc4"),
  text:   rgb("#1c1c1c"),
  meta:   rgb("#666666"),
  font:   "Libertinus Serif",
  size:   10pt,
  lang:   "de",
)

// ─── Shared utilities ─────────────────────────────────────────────────────────

#let bm-icon(name, color: bm-defaults.meta, width: 0.8em) = {
  let map = (
    bluesky:  "bluesky",
    email:    "envelope",
    github:   "github",
    linkedin: "linkedin",
    location: "location-dot",
    orcid:    "orcid",
    phone:    "phone",
    twitter:  "x-twitter",
    website:  "earth-americas",
  )
  box(width: width, align(center)[
    #fa-icon(map.at(name, default: name), solid: true, fill: color, size: .85em)
  ])
}

// Large page-level heading with full-width underline rule
#let bm-page-heading(title, theme, a: center) = align(a)[
  #text(size: 28pt, fill: theme.accent, weight: "regular")[#title]
  #v(-5pt)
  #line(length: 100%, stroke: 1pt + theme.accent)
  #v(1em)
]

// CV section header: filled blue bar + title text
// sticky: true prevents a page break between the heading and the first entry below it
#let bm-section-header(title, theme) = {
  let block-width = 2.65cm
  block(sticky: true)[
    #grid(
      columns: (block-width, auto),
      gutter: 1em,
      align: horizon,
      rect(width: block-width, height: 5pt, fill: theme.accent, stroke: none),
      text(size: 13pt, fill: theme.accent, weight: "semibold")[#title],
    )
    #v(.4em)
  ]
}

// ─── Cover page (Deckblatt) ───────────────────────────────────────────────────

#let render-cover(personal, position, toc, theme) = page(
  paper: "a4",
  margin: (x: 2.5cm, top: 2.5cm, bottom: 3cm),
)[
  #set text(font: theme.font, size: theme.size, fill: theme.text)

  #bm-page-heading(tr("cover-documents", theme.lang), theme)

  #v(4cm)

  // Name: first name in accent colour, last name in body colour
  #text(size: 38pt, fill: theme.accent, weight: "regular")[#personal.at("first-name")]#text(
    size: 38pt, weight: "regular",
  )[ #personal.at("last-name")]

  #v(.3em)
  #text(size: 9pt)[
    #personal.at("address-street"), #personal.at("address-city")
    #h(1.5em)
    #bm-icon("phone") #h(2pt) #personal.phone
    #h(1.5em)
    #bm-icon("email") #h(2pt) #personal.email
  ]

  #v(5em)
  #text(weight: "semibold")[#tr("application-for", theme.lang) 
  #position]

  #v(1fr)

  #if toc.len() > 0 [
    #bm-section-header(tr("contents", theme.lang), theme)
    #v(.3em)
    #for (title, page) in toc [
      #title #box(width: 1fr, repeat[.]) #str(page) \
    ]
  ]
]

// ─── Cover letter (Anschreiben) ───────────────────────────────────────────────

// letter dict keys: position (str), date (str), recipient (dict), body (content)
#let render-letter(personal, letter, theme) = page(
  paper: "a4",
  margin: (x: 2.5cm, top: 2.5cm, bottom: 3cm),
)[
  #set text(font: theme.font, size: theme.size, fill: theme.text)
  #set par(justify: true)

  #bm-page-heading(tr("cover-letter", theme.lang), theme)

  // Sender block — right-aligned
  #align(right)[
    #text(weight: "semibold", fill: theme.accent)[#personal.at("first-name")] #text(weight: "semibold")[#personal.at("last-name")] \
    #personal.at("address-street") \
    #personal.at("address-city") \
    #bm-icon("phone") #h(2pt) #personal.phone \
    #bm-icon("email") #h(2pt) #personal.email
  ]

  #v(1em)

  // Recipient (left) + date (right)
  #grid(
    columns: (1fr, auto),
    gutter: 1em,
    [
      #letter.recipient.contact \
      #letter.recipient.company \
      #letter.recipient.street \
      #letter.recipient.city
    ],
    align(right)[#letter.date],
  )

  #v(2.5em)
  #text(weight: "semibold")[#tr("application-for", theme.lang) #letter.position]
  #v(2em)

  #letter.body

  #v(1em)
  #if "signature" in personal {
    image(personal.signature, height: 1.5cm)
  }
]

// ─── Sidebar ──────────────────────────────────────────────────────────────────

#let sidebar-heading(title, theme) = [
  #text(weight: "semibold", fill: theme.accent, size: 10pt)[#title]
  #v(-.5em)
  #line(length: 100%, stroke: .5pt + theme.accent)
  #v(-.35em)
]

#let skill-row(name, level, theme) = grid(
  columns: (1fr, auto),
  gutter: .3em,
  text(size: 8.5pt)[#name],
  text(size: 8.5pt, weight: "semibold", fill: theme.accent)[#level],
)

#let render-sidebar(sidebar, theme) = {
  set text(font: theme.font, size: 9pt, fill: theme.text)
  set par(leading: 0.4em)

  if "languages" in sidebar {
    sidebar-heading(tr("languages", theme.lang), theme)
    for lang in sidebar.languages {
      skill-row(lang.name, lang.level, theme)
      v(-.5em)
    }
    v(1.2em)
  }

  if "it-skills" in sidebar {
    sidebar-heading(tr("it-skills", theme.lang), theme)
    for group in sidebar.at("it-skills") {
      v(.25em)
      [#text(weight: "semibold", size: 9pt)[#group.category]]
      for item in group.items {
        skill-row(item.name, item.level, theme)
        v(-.5em)
      }
      v(.5em)
    }
    v(1.2em)
  }

  if "licenses" in sidebar {
    sidebar-heading(tr("licenses", theme.lang), theme)
    v(.1em)
    for m in sidebar.licenses {
      [
        #text(size: 9pt)[#m] #v(-4pt)
      ]
    }
    v(1.2em)
  }


  if "methods" in sidebar {
    sidebar-heading(tr("methods", theme.lang), theme)
    v(.1em)
    for m in sidebar.methods {
      [
        #text(size: 9pt)[#m] #v(-4pt)
      ]
    }
  }
}

// ─── Lebenslauf header ────────────────────────────────────────────────────────

#let contact-grid(personal, theme) = {
  let icon-space = 4pt
  let icon-width = 0.8em
  let item-spacing = 0.6em

  // Collect all items in a single list, then split into two columns with a vertical midpoint.
  let items =(
    [#bm-icon("location", color: theme.accent, width: icon-width) #h(icon-space) #personal.at("address-street")\ #h(icon-width + 1.5*icon-space) #personal.at("address-city")],
    [#bm-icon("email",    color: theme.accent, width: icon-width) #h(icon-space) #link("mailto:"+personal.email)[#personal.email]],
    [#bm-icon("phone",    color: theme.accent, width: icon-width) #h(icon-space) #link("tel:"+personal.phone)[#personal.phone]],
    [#bm-icon("website",  color: theme.accent, width: icon-width) #h(icon-space) #link(personal.website)[#personal.website.split("//").at(-1)]]
  )
  if "profiles" in personal {
    items += personal.profiles.map(p =>
      [#bm-icon(lower(p.network), color: theme.accent, width: icon-width) #h(icon-space) #link(p.url)[#p.url.split("//").at(-1)]]
    )
  }
  let mid = calc.floor(items.len() / 2)

  grid(
    columns: (1fr, 1fr),
    gutter: .5em,
    stack(dir: ttb, spacing: item-spacing, ..items.slice(0, mid)),
    stack(dir: ttb, spacing: item-spacing, ..items.slice(mid)),
  )
}

#let render-cv-header(personal, theme) = {
  set align(center)

  // Page title
  text(size: 14pt, fill: theme.text, weight: "regular")[#smallcaps("Curriculum Vitae")]
  v(1.15em)

  // Name
  text(size: 22pt, weight: "regular", fill: theme.accent)[#personal.at("first-name")]
  text(size: 22pt, weight: "regular")[ #personal.at("last-name")]

  // Optional titles / degrees
  if "titles" in personal and personal.titles.len() > 0 {
    // linebreak()
    v(.1em)
    text(size: theme.size)[#for t in personal.titles { t }]
  }

  v(.3em)
  line(length: 80%, stroke: .5pt + theme.accent)
  v(.3em)

  // Two-column contact grid
  block(width: 80%)[
    #set align(left)
    #contact-grid(personal, theme)
  ]

  v(.3em)
  line(length: 80%, stroke: .5pt + theme.accent)
  v(2.5em)

  // Circular photo — placed last so it paints on top of all other elements
  if "photo" in personal {
    place(top + right,
      dx: 20pt,
      dy: -27pt,
      box(clip: true,
          stroke: 2pt + theme.meta,
          radius: 100%,
          width: 4cm, height: 4cm,
          image(personal.photo, height: 4cm))
    )
  }
}

// ─── Lebenslauf (all sections, natural page flow) ─────────────────────────────

#let render-cv(data, theme) = {
  let cv = data.cv
  page(paper: "a4", margin: (x: 2.5cm, y: 2.5cm))[
    #set text(font: theme.font, size: theme.size, fill: theme.text)
    #set par(justify: true)

    #render-cv-header(data.personal, theme)

    // ── Two-column zone: (Summary + Kernkompetenzen) | sidebar ──
    #if "motivation" in cv or "core-competencies" in cv or "sidebar" in cv {
      grid(
        columns: (1fr, 5.5cm),
        gutter: 2.5em,
        [
          #if "motivation" in cv {
            bm-section-header(tr("professional-summary", theme.lang), theme)
            [
              #set text(size: 9pt, style: "normal")
              #set par(justify: true)
              #eval(cv.motivation, mode: "markup")
            ]
            let _ = cv.remove("motivation")
            v(1.2em)
          }
          #if "core-competencies" in cv {
            bm-section-header(tr("core-competencies", theme.lang), theme)
            for group in cv.at("core-competencies") [
              #align(center)[
                #text(size: 10pt, fill: theme.accent)[#smallcaps(group.title)]
              ]
              #v(.15em)
              #eval(group.details, mode: "markup")
              #v(.3em)
            ]
            let _ = cv.remove("core-competencies")
            v(1.2em)
          }
        ],
        [
          #if "sidebar" in cv {
            render-sidebar(cv.sidebar, theme)
            let _ = cv.remove("sidebar")
          }
        ],
      )
    }

    // ── Full-width zone: flows naturally across pages ──

    #for (section-name, content) in cv [
      #if section-name.starts-with("_") {
        break
      }
      #let (keys, renderer) = cv-section-registry.at(section-name)

      #bm-section-header(tr(section-name, theme.lang), theme)
      #renderer(section-name, content, keys, theme)
      #v(1.2em)
    ]

    // ── Signature at end of CV ──
    #if "signature" in data.personal {
      v(2.5em)
      image(data.personal.signature, height: 1.5cm)
    }
  ]
}

// ─── Certificates placeholder (Zeugnisse & Zertifikate) ───────────────────────

#let render-certificates(data, theme) = {
  set text(font: theme.font, size: theme.size)
  bm-page-heading(tr("certificates", theme.lang), theme)

  if data.len() != 0 {
    set text(font: theme.font, weight: "regular", size: 1.4em, fill: theme.text)
    set list(spacing: 1.3em, indent: 2cm)
    v(2cm)

    show: checklist.with(marker-map: (
      "file": text(baseline: -.4em, size: 1.5em)[#fa-file(solid: false)],
    ))
    for certificate in data [
      - [file] #certificate \
    ]
  }
}

// ─── Publications (Veröffentlichungen) ───────────────────────────────────────
#let render-publications(data, theme) = [
  #set text(font: theme.font, size: theme.size, fill: theme.text)
  #set par(justify: true)

  #bm-page-heading(tr("publications", theme.lang), theme)

  #let bib-sections = (
    ("pub-articles",   ("article")),
    // ("pub-proceeding", ("inproceedings", "proceedings")),
    ("pub-proceeding", ("conference")),
    ("pub-reports",    ("techreport", "report")),
    ("pub-conference", ("conference", "inproceedings", "proceedings")),
    ("pub-theses",     ("phdthesis", "mastersthesis", "thesis")),
  )

  #show link: it => {
    set text(fill: theme.accent)
    it
  }

  // Pre-parse bib to skip empty sections
  #let _parsed-bib = parse-bib(read("/publications.bib"))
  #add-bib-resource(read("/publications.bib"))

  #for (section, types) in bib-sections {
    // Skip if no entries of the given type(s) are present in the bibliography
    let has-entries = _parsed-bib.values().any(r => r.entry_type in types)
    if not has-entries { continue }
    
    let style = format-citation-numeric()
    refsection(style: numeric-style())[
      #print-bibliography(
        title: bm-section-header(tr(section, theme.lang), theme), 
        filter: r => r.entry_type in types,
        show-all: true, 
        resume-after: auto,
        sorting: "ydnt", 
        outlined: false,
        format-reference: format-reference(
          print-identifiers: ("doi", "url"),
          link-titles: false,
          reference-label: style.reference-label,
          format-quotes: it => ["#it"],
          print-date-after-authors: true,
          comma: ",",
          maxnames: 3,
          format-fields: (
            "author": (ddfmt, value, reference, field, options, style) => {
              let formatted-names = value.map(d => {
                let highlighted = (d.family == data.personal.last-name)
                let name = format-name(d, format: "{family}")
                if highlighted { strong(name) } else { name }
              })
              concatenate-names(formatted-names, maxnames: 3)
            }
          )
        ),
        // label-generator: style.label-generator
      )
    ]
  v(1em)
  }
]


// ─── Theme builder ────────────────────────────────────────────────────────────

// Build a theme dict by merging bm-defaults with optional YAML settings block.
#let build-theme(data) = {
  let theme = bm-defaults
  if "settings" in data {
    let s = data.settings
    if "accent" in s { theme.insert("accent", eval(s.accent)) }
    if "text"   in s { theme.insert("text",   eval(s.text)) }
    if "meta"   in s { theme.insert("meta",   eval(s.meta)) }
    if "font"   in s { theme.insert("font",   s.font) }
    if "size"   in s { theme.insert("size",   eval(s.size)) }
    if "lang"   in s { theme.insert("lang",   s.lang) }
  }
  theme
}
