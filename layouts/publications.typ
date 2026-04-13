// Publications — standalone entry point.
// Compile with:  typst compile --root . layouts/publications.typ publications.pdf

#import "../src/application_docs.typ": render-publications, build-theme

#let config = yaml("/config.yml")
#let theme = build-theme(config)

#render-publications(theme)
