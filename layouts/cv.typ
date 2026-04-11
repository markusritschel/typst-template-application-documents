// CV-only entry point — no cover page, no letter, no certificates.
// Compile with:  typst compile --root . template/lebenslauf.typ

#import "../src/application_docs.typ": render-cv, build-theme

#let config = yaml("/config.yml")
#let lang = config.settings.lang
#let cvdata = yaml("/cv-data." + lang + ".yml")
#let data = config + cvdata
#let theme = build-theme(data)
#render-cv(data, theme)
