# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- **Publication list** (`layouts/publications.typ`): New standalone layout that renders a publications page from a `publications.bib` file. Compile with `typst compile --root . layouts/publications.typ publications.pdf` or via `just publications`.
- **Publication categories**: Publications are automatically grouped into labelled sections (Journal Articles, Conference Contributions, Technical Reports, Theses) based on BibTeX entry types. Sections with no matching entries are skipped. The author matching the CV owner's last name is highlighted in bold.
- **Section skipping via underscore prefix**: Any CV section whose key starts with `_` is silently skipped during rendering — useful for drafting or temporarily hiding sections without deleting them.
- **Justfile `mode` parameter**: All `just` targets now accept an optional `mode` argument (`compile` or `watch`). For example, `just cv watch` switches a target into watch mode without needing a separate recipe.
- **New translation keys** in `src/translate.yml`: `pub-articles`, `pub-conference`, `pub-reports`, `pub-theses` (English and German).
- **New Typst dependencies**: `@preview/pergamon:0.8.0` and `@preview/citegeist:0.2.2` for bibliography parsing and rendering.
- **`toc` and `certificates` in `config.yml`** (#7): The cover page table of contents and the certificates list are now configured directly in `config.yml`. No layout `.typ` file needs to be edited for these anymore.
- **Multi-language Support**: CV content is now language-specific with separate YAML files (`cv-data.en.yml`, `cv-data.de.yml`, etc.)
- **Dynamic Language Loading**: Language setting in `config.yml` automatically determines which CV data file is loaded at compile time
- **German Translation**: Complete German translation of CV data file (`cv-data.de.yml`)
- **Markdown Cover Letter** (#1): Cover letters can now be written in Markdown with YAML frontmatter for metadata
  - No need to edit `.typ` files—users only edit `cover-letter.md`
  - Recipient data, position, and date in YAML frontmatter
  - Letter body supports full Markdown formatting
  - Built on `cmarker` package for frontmatter parsing
- **CHANGELOG.md**: This file to track project changes

### Changed
- **Personal section moved to CV YAML** (#10): The `personal:` block has been moved from `config.yml` into `cv-data.{lang}.yml`. Personal information is content, not configuration, so it now lives alongside the rest of the CV data. `config.yml` now contains only `settings:`, `toc:`, and `certificates:`.
- **Cover Letter body**: The applicant's name is no longer automatically appended to the rendered cover letter. Add it manually as part of the closing in `cover-letter.md`.
- **CV spacing and font sizes**: Corrected vertical spacing between entry titles and descriptions, sidebar font size, and spacing around commas throughout the CV.
- **CV section order**: The order in which CV sections appear in the rendered document now follows the key order in `cv-data.{lang}.yml`. Reorder sections in that file to change their order in the PDF—no template editing needed.
- **CV header contact grid** (#6): All contact details (location, email, phone, website) and social profiles are now displayed together in a single unified two-column grid with consistent icon alignment.
- **Configuration Refactoring**: Consolidated configuration into a single `config.yml` file
  - Contains `settings` block (theme, colors, fonts, language)
  - Contains `personal` block (contact details, photo, signature, social profiles)
- **Cover Letter Workflow**: Users no longer edit `layouts/cover-letter.typ` for letter content
  - Letter content moved to `cover-letter.md` with YAML frontmatter
  - `layouts/cover-letter.typ` now only handles Markdown parsing and rendering
- **File Structure**: Separated CV data from configuration
  - Old: Single `personal-data.yml` file with mixed content
  - New: `config.yml` (settings + personal details) + `cv-data.{lang}.yml` (language-specific CV content)
- **Typst Layouts**: Updated all layout files to dynamically load config and language-specific CV data
  - `layouts/application-documents.typ`
  - `layouts/cover-letter.typ`
  - `layouts/cv.typ`
- **Documentation**: Updated README.md with comprehensive language support instructions
  - Clarified file structure and configuration approach
  - Added notes on file path conventions (absolute paths with `/` refer to project root)
  - Added section on adding new languages
  - Updated cover letter workflow documentation

### Removed
- **personal-data.yml**: Replaced by `config.yml` and `cv-data.{lang}.yml` files
- **application-settings.yml**: Merged into `config.yml`
- **personal-info.yml**: Content merged into `config.yml` as `personal` section

### Fixed
- File path documentation now clearly explains that paths starting with `/` (e.g., `/photo.png`) refer to the project root directory, not system root

## [0.1.0] - 2026-01-01

### Added
- Complete job application package template with cover letters, CVs, and supporting documents
- Data-driven approach with YAML configuration
- Multi-column CV layout with sidebar for skills and languages
- Customizable colors, fonts, and spacing
- Markdown support for letter bodies
- Multi-language translation strings
- Justfile shortcuts for common compilation tasks

---

[0.1.0]: https://github.com/markusritschel/typst-template-application-documents/releases/tag/v0.1.0
