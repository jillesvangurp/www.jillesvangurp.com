#! /usr/bin/env bash
export navigation=$(cat navigation.html)

for page in $(ls pages); do
  pandoc --from markdown_github+smart+yaml_metadata_block+auto_identifiers "pages/$page" \
    -o "public/$(basename $page .md).html" \
    --template templates/page.html\
    -V year="$(date +%Y)" \
    -V navigation="$navigation" 

done

