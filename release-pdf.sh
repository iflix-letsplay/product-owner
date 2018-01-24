#!/bin/bash
if [ $# -ne 2 ]; then
    echo 'usage: ./release-pdf.sh <release version> <pdf name>'
    exit 1
fi
bundle install && PO_TOKEN=cea9a05c311ed1996b973477f01773f847047f37 bundle exec ruby release-notes.rb $1 > $2.md
mdpdf $2.md
rm $2.md
