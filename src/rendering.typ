
// Two-column timeline row: narrow right-aligned date | wide content
#let cv-row(date, body, theme) = {
  grid(
    columns: (2.5cm, 1fr),
    gutter: 1em,
    align: (right + top, left + top),
    text(size: 8.5pt, fill: theme.meta)[#date],
    body,
  )
  v(.3em)
}

// Define views for CV sections

#let timeline-view(section-name, items, keys, theme) = {
  let institution-key = if "institution" in keys { "institution" } else if "employer" in keys { "employer" } else { "" }

  for entry in items [
    #let institution = entry.at(institution-key, default: "")
    #let location = entry.at("location", default: "")
    #let description = entry.at("description", default: "")

    #cv-row(
      entry.date, 
      [
        #block(sticky: true)[
          #text(weight: "bold")[#entry.title]
          #if institution.len() > 0 [, #text(style: "italic")[#institution]]
          #if location.len() > 0 [, #location].
          #if description.len() > 0 [
            #v(.1em)
            #text(size: 9pt)[#eval(description, mode: "markup")]
          ]
        ]
      ],
      theme
    )
  ]
}

#let label-view(section-name, items, keys, theme) = {
  let description-key = if "description" in keys { "description" } 
                   else if "text" in keys { "text" } 
                   else if "title" in keys { "title" } 
                   else { "" }
  
  for entry in items [
    #cv-row(
      entry.label,
      [
        #set text(size: 9pt, style: "normal")
        #eval(entry.at(description-key), mode: "markup")#if "url" in entry { " (" + link(entry.url)[#entry.url] + ")" }
      ],
      theme
    )
  ]
}

// ——— Section Registry — each section is optional and only renders if corresponding data is present in the YAML file. 

#let cv-section-registry = (
  "education": (
    keys: ("date", "title", "institution", "location", "description"),
    renderer: timeline-view,
  ),
  "work-experience": (
    keys: ("date", "title", "employer", "location", "description"),
    renderer: timeline-view,
  ),
  "continuing-education": (
    keys: ("date", "title", "description"),
    renderer: timeline-view,
  ),
  "volunteering": (
    keys: ("label", "text", "url"),
    renderer: label-view
  ),
  "publications": (
    keys: ("label", "title", "url"),
    renderer: label-view
  ),
)
