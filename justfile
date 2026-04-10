# See https://just.systems/ for more information

[private]
default:
    @just --list

# Compile the full application document (Cover, Cover Letter, CV)
application-documents:
    typst compile --root=. layouts/application-documents.typ application-documents.pdf

# Compile the Cover Letter only
cover-letter:
    typst compile --root=. layouts/cover-letter.typ cover-letter.pdf

# Compile the CV only
cv:
    typst compile --root=. layouts/cv.typ cv.pdf

