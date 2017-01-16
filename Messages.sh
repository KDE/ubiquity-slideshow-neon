#!/bin/sh

file_args=""
for html_file in `find ubiquity-slideshow -name \*.html | grep -v index.html`; do
  file_args="${file_args} -m ${html_file}"
done

po4a-gettextize \
  --copyright-holder=This_file_is_part_of_KDE \
  -M UTF-8 -f xhtml -o attributes=data-translate \
  $file_args -p $podir/ubiquity-slideshow-neon.pot
