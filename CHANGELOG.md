# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
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
