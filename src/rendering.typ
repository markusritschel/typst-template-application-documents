
// Two-column timeline row: narrow right-aligned date | wide content
#let cv-row(date, body, theme) = {
  // Set text in between parantheses in regular font weight
  show regex("\(([^)]+)\)"): it => {
    // it.text gives the raw matched string
    text(weight: "regular", "(" + it.text.slice(1, -1) + ")")
  }
  grid(
    columns: (2.65cm, 1fr),
    gutter: 1em,
    align: (right + top, left + top),
    text(size: 9pt, fill: theme.meta)[#date],
    body,
  )
  v(.1em)
}

// Define views for CV sections

#let get-matching-value(dict, allowed-keys) = {
  let found = allowed-keys.find(k => k in dict)
  if found != none { dict.at(found) } else { "" }
}

#let timeline-view(entries, theme) = {
  // Allow different identifiers for institution
  let allowed-institution-key = ("institution", "institute", "employer") 
  
  for entry in entries [
    #let date = entry.date
    #let title = entry.title
    #let institution = get-matching-value(entry, allowed-institution-key)
    #let location = entry.at("location", default: "")
    #let description = entry.at("description", default: "")

    #cv-row(
      text(size: 9pt)[#date],
      [
        #block(sticky: true)[#{ // content expressions are concatenated without any automatic whitespace
          text(weight: "semibold")[#title]
          if institution.len() > 0 [, #text(style: "italic")[#institution]]
          if location.len() > 0 [, #location]
          if description.len() > 0 [
            #v(-4pt)
            #text(size: 9pt)[#eval(description, mode: "markup")]
          ]
        }]
      ],
      theme
    )
  ]
}

#let label-view(entries, theme) = {
  let allowed-infotext-keys = ("description", "text", "title") 
  
  for entry in entries [
    #let label = entry.label
    #let info-text = get-matching-value(entry, allowed-infotext-keys)
    #let url = if "url" in entry { ": "+ link(entry.url)[#entry.at("url")] } else { "" }

    #cv-row(
      text(size: 9pt)[#align(left)[#label]],
      [
        #set text(size: 9pt, style: "normal")
        #eval(info-text, mode: "markup")#url
      ],
      theme
    )
  ]
}

// ——— Section Registry — each section is optional and only renders if corresponding data is present in the YAML file. 

#let cv-section-registry = (
  "timeline": timeline-view,
  "labels": label-view
)