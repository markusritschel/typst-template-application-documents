// Bewerbungsanschreiben — standalone letter entry point.
// Edit the letter dict below for each application, then compile with:
//   typst compile --root . template/anschreiben.typ

#import "../src/application_docs.typ": render-letter, build-theme

#let config = yaml("/config.yml")
#let lang = config.settings.lang
#let cvdata = yaml("/cv-data." + lang + ".yml")
#let data     = config + cvdata
#let theme    = build-theme(data)
#let personal = data.personal

// ── Letter content — edit this for each application ──────────────────────────

#let letter = (
  position: "Donut Quality Control Specialist",
  date:     "1. April 2026",
  recipient: (
    contact: "Mr. Burns",
    company: "Springfield Nuclear Power Plant",
    street:  "Nuclear Way 1",
    city:    "Springfield, USA",
  ),
  body: [
    Dear Sir or Madam,
    
    #v(1em)

    I am writing to express my interest in the position of *Donut Quality Control Specialist*.

    #v(1em)

    Best regards,
  ],
)

// ─────────────────────────────────────────────────────────────────────────────

#render-letter(personal, letter, theme)
