#!/bin/bash
set -e
if [ -z "$PO_TOKEN" ]; then echo "PO_TOKEN is unset"; fi

if [ $# -ne 2 ] || [  -z "$PO_TOKEN" ]; then
    echo 'usage: PO_TOKEN=<private po token> ./release-pdf.sh <i||a> <release version>'
    exit 1
fi
if [ "$1" = "a" ]; then
	FILENAME="Android"
	REPO='iflix-letsplay/iflix-android'
elif [ "$1" = "i" ]; then
	FILENAME="iOS"
	REPO='iflix-letsplay/apple-ios'
else
	echo 'first arg must be "i" for iOS or "a" for Android'	
	exit 1
fi

FILENAME=$FILENAME-$2--Release-Notes
echo $FILENAME
gem install bundler
bundle install && bundle exec ruby release-notes.rb $2 $REPO> $FILENAME.md
mdpdf $FILENAME.md
rm $FILENAME.md
