#! /usr/bin/env bash
export navigation=$(cat navigation.html)

rm -f _sidebar.md

current_year="-"
for name in $(find articles -type f -exec basename {} \; | sort -ur | sed 's/\.md//' | head -n 30); do
  year=$(echo $name | sed -E 's/([0-9]{4})-([0-9]{2})-([0-9]{2})-(.*)/\1/')
  month=$(echo $name | sed -E 's/([0-9]{4})-([0-9]{2})-([0-9]{2})-(.*)/\2/')
  day=$(echo $name | sed -E 's/([0-9]{4})-([0-9]{2})-([0-9]{2})-(.*)/\3/')
  title=$(echo $name | sed -E 's/([0-9]{4})-([0-9]{2})-([0-9]{2})-(.*)/\4/')
  nice_title=$(echo "$year-$month-$day - $(echo ${title:0:1} | tr  '[a-z]' '[A-Z]' )${title:1}" | sed -e 's/-/ /g')
  if [ $year != $current_year ]; then
    echo -e "\n## $year\n" >> _sidebar.md
  fi
  current_year=$year
  echo "- [$nice_title](/blog/$year/$month/$day/$title)" >> _sidebar.md
done

pandoc --from markdown+smart+yaml_metadata_block+auto_identifiers "_sidebar.md" \
  -o "_sidebar.html" 


for page in $(ls pages); do
  pandoc --from markdown+smart+yaml_metadata_block+auto_identifiers "pages/$page" \
    -o "public/$(basename $page .md).html" \
    --template templates/page.html\
    -V navigation="$(cat navigation.html)" \
    -V footer="$(cat footer.html)" \
    -V sidebar="$(cat _sidebar.html)"
done

rm -f _sidebar.md _sidebar.html
