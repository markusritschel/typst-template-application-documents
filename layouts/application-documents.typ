// Application Documents — full application package entry point.
// Compile with:  typst compile --root . layouts/application-documents.typ

#import "../src/application_docs.typ": render-cover, render-letter, render-cv, render-certificates, render-publications, build-theme
#import "cover-letter.typ": letter   // import letter data only (does not render here)

#let config = yaml("/config.yml")
#let lang = config.settings.lang
#let cvdata = yaml("/cv-data." + lang + ".yml")
#let data = config + cvdata
#let theme = build-theme(data)
#let toc = config.at("toc", default: ())
#let certificates = config.at("certificates", default: ())

#render-cover(data.personal, letter.position, toc, theme)
#render-letter(data.personal, letter, theme)
#render-cv(data, theme)
#render-publications(theme)
#render-certificates(certificates, theme)
