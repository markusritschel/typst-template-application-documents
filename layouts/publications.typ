// Publications — standalone entry point.
// Compile with:  typst compile --root . layouts/publications.typ publications.pdf

#import "../src/application_docs.typ": render-publications, build-theme

#let config = yaml("/config.yml")
#let lang = config.settings.lang
#let cvdata = yaml("/cv-data." + lang + ".yml")
#let data = config + cvdata
#let theme = build-theme(data)

#render-publications(data, theme)
