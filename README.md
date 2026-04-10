# Application Documents Template

A Typst template for generating complete job application packages with cover letters, CVs, and supporting documents. 
Data-driven from YAML, fully customizable styling.

![](thumbnail.png)

## Features

- **Data-Driven**: All content is separated from layout
- **Complete Application Package**: Cover page, cover letter, CV (multi-column + sidebar), and certificates cover page
- **Flexible Styling**: Customize colors, fonts, spacing via YAML settings
- **Markdown Support**: Write letter bodies with support for Markdown formatting and paragraph spacing
- **Multi-language Ready**: Translation strings via `src/translate.yml`

## Quick Start

### 1. Install Typst

See https://typst.app/ for details.

### 2. Customize Your Data

Edit `personal-data.yml` with your information:
- Personal details (name, address, contact, photo)
- CV sections (education, work experience, skills, languages, etc.)
- Theme colors and fonts

> [!Important]
> Your root directory must contain at least your `personal-data.yml`.
> The `photo.png` and the `signature.png` are optional, but if you choose not to include either of them, make sure to remove the corresponding entries from `personal-data.yml` to avoid compilation errors.

### 3. Optional: Write your Cover Letter

Edit `layouts/cover-letter.typ` to customize the cover letter for each application:
```typst
#let letter = (
  position: "Your Target Job Title",
  date: "Today's Date",
  recipient: (
    contact: "Hiring Manager Name",
    company: "Company Name",
    street: "Street Address",
    city: "City, Country",
  ),
  body: [
    Letter content here with **bold**, *italic*, etc.
  ],
)
```

Of course, you can also just compile the CV without a cover letter.

### 4. Compile

```bash
# Full application package
typst compile --root . layouts/cv.typ cv.pdf

# Full application package
typst compile --root . layouts/application-documents.typ full-application.pdf

# Just the cover letter
typst compile --root . layouts/cover-letter.typ cover-letter.pdf

# Watch mode (auto-recompile on changes; great for writing)
typst watch --root . layouts/application-documents.typ full-application.pdf
```

> [!Tip]
> If you have justfile installed, you can also use shortcuts for these commands. 
> Simply run `just` in your terminal to see the available commands and execute them as needed.

> [!Note]
> Note that Typst cannot automatically update page numbers, so if you change the content, make sure to update the `toc` variable in `layouts/application-documents.typ` with the correct page numbers for each section.

## Project Structure

```
├── README.md                    # This file
├── typst.toml                   # Package metadata
├── personal-data.yml            # Your personal data (YAML)
├── src/
│   ├── application_docs.typ     # Main template functions
│   └── translate.yml            # Multi-language strings
└── layouts/
    ├── application-documents.typ # Full package entry point
    ├── cover-letter.typ         # Letter-only entry point
    └── cv.typ                   # CV-only entry point
```

## Customization

### Colors & Fonts

Edit the `settings:` block in `personal-data.yml`:

```yaml
settings:
  lang:   en
  accent: rgb("#435476")    # Primary color (headers, emphasis)
  text:   rgb("#1c1c1c")    # Body text color
  meta:   rgb("#666666")    # Secondary text (dates, labels)
  font:   "Libertinus Serif"
  size:   10pt
```

### CV Sections

The template supports these section layouts:

```yaml
cv:
  motivation: "Professional summary paragraph"
  core-competencies:
    - title: "Category"
      items:
        - "Competency description"
  education:
    - date: "10/2020 – 06/2024"
      title: "Degree Name"
      institution: "University"
      location: "City"
      description: "Additional notes"
  work-experience:
    - date: "01/2024 – present"
      title: "Job Title"
      employer: "Company"
      location: "City"
      description: "Duties and achievements"
  sidebar:
    languages:
      - name: "Language"
        level: "Proficiency"
    it-skills:
      - category: "Category"
        items:
          - name: "Skill"
            level: "Expert"
    methods:
      - "Method or skill"
  volunteering:
    - label: "Activity Type"
      text: "Description"
  continuing-education:
    - date: 2024
      title: "Course/Certificate"
      description: "Brief description"
  publications:
    - label: "Label"
      title: "Publication Title"
      url: "https://example.com"
```

For more examples of how to structure the CV sections, see `personal-data.yml`.

### Cover Letter spacing

Control vertical spacing in cover letters via blank lines or Typst spacing commands:

```typst
body: [
  Dear Sir or Madam,

  Body paragraph here.

  #v(2em)  # Add explicit spacing before closing

  Best regards,
],
```


## Tipps
- Keep `personal-data.yml`, `photo.png`, and `signature.png` private (add to `.gitignore`)
- Alternatively, use this repository as a submodule in a private repository and copy the `layouts` directory. Remember to update the import paths in the layout files if you change the directory structure.
- Use separate branches for branching applications by employer

  <details>
  <summary>Example: Branching workflow</summary>

  For job applications, create a branch per application:

  ```bash
  git checkout -b application/company-name
  # Edit personal-data.yml and layouts/cover-letter.typ
  typst compile --root . layouts/application-documents.typ "Application_CompanyName.pdf"
  git add -A && git commit -m "Application: Company Name"
  git tag application/company-name
  ```

  This keeps the main branch clean while maintaining a history of all applications.
  </details>


## Requirements

- **Typst** ≥ 0.14.2
- `@preview/fontawesome:0.6.0` (automatically downloaded)

## License

MIT — See [LICENSE](LICENSE) for details.

## Credits

Built with [Typst](https://typst.app/) and [FontAwesome](https://fontawesome.com/). \
Thanks to rajgeophysik for inspiration on design and layout.
