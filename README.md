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

The template uses a language-based configuration approach:

**Configuration Files:**
- `config.yml` - Settings (colors, fonts, language) and personal details
- `cv-data.{lang}.yml` - Language-specific CV content (e.g., `cv-data.en.yml`, `cv-data.de.yml`)

Edit `config.yml` with your personal information and styling:
- Personal details (name, address, contact, photo)
- Theme colors and fonts
- Language setting (controls which CV data file is loaded)

Create language-specific CV data files (e.g., `cv-data.en.yml` for English, `cv-data.de.yml` for German) with your CV sections:
- Education, work experience, skills, languages, etc.

To change the language, simply update the `lang` setting in `config.yml` and the appropriate language-specific CV file will be loaded automatically.

> [!Important]
> Your root directory must contain:
> - `config.yml` (required) 
> - At least one `cv-data.{lang}.yml` file matching your chosen language
> 
> The `photo.png` and `signature.png` are optional. If you choose not to include them, remove the corresponding entries from `config.yml` to avoid compilation errors.
>
> **Note on file paths:** Paths starting with `/` (e.g., `/photo.png`, `/signature.png`) refer to the project root directory, not the system root.

### 3. Write your Cover Letter

Edit `cover-letter.md` to customize the cover letter for each application. The file uses YAML frontmatter for metadata and Markdown for the letter body:

```markdown
---
position: Your Target Job Title
date: Today's Date
recipient:
  contact: Hiring Manager Name
  company: Company Name
  street: Street Address
  city: City, Country
---

Dear Sir or Madam,

Letter content here with **bold**, *italic*, and other Markdown formatting.

Best regards,
```

The YAML frontmatter contains all application-specific information, while the Markdown body supports full formatting. You don't need to edit any `.typ` files—just this one Markdown file per application!

Of course, you can also just compile the CV without a cover letter.

### 4. Compile

```bash
# Full application package
typst compile --root . layouts/application-documents.typ full-application.pdf

# Just the CV
typst compile --root . layouts/cv.typ cv.pdf

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
├── README.md                      # This file
├── typst.toml                     # Package metadata
├── config.yml                     # Settings & personal data (YAML)
├── cv-data.en.yml                 # English CV content (YAML)
├── cv-data.de.yml                 # German CV content (YAML)
├── photo.png                       # Your photo (optional)
├── signature.png                   # Your signature (optional)
├── src/
│   ├── application_docs.typ        # Main template functions
│   └── translate.yml               # Multi-language strings
└── layouts/
    ├── application-documents.typ   # Full package entry point
    ├── cover-letter.typ            # Letter-only entry point
    └── cv.typ                      # CV-only entry point
```

## Customization

### Colors, Fonts & Language

Edit the `settings:` block in `config.yml`:

```yaml
settings:
  lang:   en                        # Language: 'en', 'de', etc.
  accent: rgb("#435476")            # Primary color (headers, emphasis)
  text:   rgb("#1c1c1c")            # Body text color
  meta:   rgb("#666666")            # Secondary text (dates, labels)
  font:   "Libertinus Serif"
  size:   10pt
```

Changing the `lang` setting automatically loads the corresponding `cv-data.{lang}.yml` file.

### Personal Information

Edit the `personal:` block in `config.yml`:

```yaml
personal:
  first-name: John
  last-name: Doe
  address-street: "Street Address"
  address-city: "City, Country"
  phone: "+1 (555) 000-0000"
  email: john@example.com
  website: https://example.com
  photo: /photo.png
  signature: /signature.png
  titles: [Ph.D.]
  profiles:
    - network: GitHub
      url: https://github.com/johndoe
```

### CV Sections

Create language-specific CV data files like `cv-data.en.yml` with these sections:

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

For more examples of how to structure the CV sections, see `cv-data.en.yml` or `cv-data.de.yml`.

### Adding More Languages

To support additional languages:

1. Create a new language-specific CV data file: `cv-data.{lang}.yml` (e.g., `cv-data.fr.yml` for French)
2. Update the `lang` setting in `config.yml` to your desired language code
3. Ensure `src/translate.yml` contains translations for your language

When you compile with the updated language setting, the template will automatically load the corresponding CV data file.

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


## Tips

- Keep `config.yml`, `photo.png`, `signature.png`, and your `cv-data.{lang}.yml` files private (add to `.gitignore`)
- Alternatively, use this repository as a submodule in a private repository and copy the `layouts` directory. Remember to update the import paths in the layout files if you change the directory structure.
- Use separate branches for different job applications

  <details>
  <summary>Example: Branching workflow</summary>

  For job applications, create a branch per application:

  ```bash
  git checkout -b application/company-name
  # Edit config.yml and layouts/cover-letter.typ
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
