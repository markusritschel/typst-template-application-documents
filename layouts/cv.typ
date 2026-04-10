// CV-only entry point — no cover page, no letter, no certificates.
// Compile with:  typst compile --root . template/lebenslauf.typ

#import "../src/application_docs.typ": render-cv, build-theme

#let data  = yaml("/personal-data.yml")
#let theme = build-theme(data)
#render-cv(data, theme)
