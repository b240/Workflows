#!/bin/sh
set -e

# MKDOC

asciidoc    Readme.adoc
wkhtmltopdf Readme.html Readme.pdf
