# See https://just.systems/ for more information

[private]
default:
    @just --list

# Compile the full application document (Cover, Cover Letter, CV)
application-documents mode="compile":
    typst {{mode}} --root=. layouts/application-documents.typ application-documents.pdf

# Compile the Cover Letter only
cover-letter mode="compile":
    typst {{mode}} --root=. layouts/cover-letter.typ cover-letter.pdf

# Compile the CV only
cv mode="compile":
    typst {{mode}} --root=. layouts/cv.typ cv.pdf
