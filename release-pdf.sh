#!/bin/bash
set -e
if [ -z "$PO_TOKEN" ]; then echo "PO_TOKEN is unset"; fi

if [ $# -ne 2 ] || [  -z "$PO_TOKEN" ]; then
    echo 'usage: PO_TOKEN=<private po token> ./release-pdf.sh <release version> <pdf name>'
    exit 1
fi
bundle install && bundle exec ruby release-notes.rb $1 > $2.md
mdpdf $2.md
rm $2.md
