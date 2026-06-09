// Bewerbungsanschreiben — standalone letter entry point.
// Edit the motivation-letter.md file for each application, then compile with:
//   typst compile --root . layouts/motivation-letter.typ

#import "@preview/cmarker:0.1.8"
#import "../src/application_docs.typ": render-letter, build-theme

// Load configuration and CV data
#let config = yaml("/config.yml")
#let lang = config.settings.lang
#let cvdata = yaml("/cv-data." + lang + ".yml")
#let data = config + cvdata
#let theme = build-theme(data)
#let personal = data.personal


// #render-letter(personal, letter, theme)
#let (letter, body) = cmarker.render-with-metadata(read("/motivation-letter.md"), metadata-block: "frontmatter-yaml")

#letter.insert("body", body)

#render-letter(personal, letter, theme, letter-type: "motivation-letter")
