#! /usr/bin/env bash
rm -f _index.md
export HEADER=$(cat index-header.md)

echo "$HEADER" > _index.md

current_year="-"
for name in $(find articles -type f -exec basename {} \; | sort -ur | sed 's/\.md//'); do
  year=$(echo $name | sed -E 's/([0-9]{4})-([0-9]{2})-([0-9]{2})-(.*)/\1/')
  month=$(echo $name | sed -E 's/([0-9]{4})-([0-9]{2})-([0-9]{2})-(.*)/\2/')
  day=$(echo $name | sed -E 's/([0-9]{4})-([0-9]{2})-([0-9]{2})-(.*)/\3/')
  title=$(echo $name | sed -E 's/([0-9]{4})-([0-9]{2})-([0-9]{2})-(.*)/\4/')
  nice_title=$(echo "$year-$month-$day - $(echo ${title:0:1} | tr  '[a-z]' '[A-Z]' )${title:1}" | sed -e 's/-/ /g')
  if [ $year != $current_year ]; then
    echo -e "\n## $year\n" >> _index.md
  fi
  current_year=$year
  echo "- [$nice_title](/$year/$month/$day/$title)" >> _index.md

done

pandoc --from markdown+smart+yaml_metadata_block+auto_identifiers "_index.md" \
  -o "public/blog/index.html" \
  --template templates/article.html \
  -V navigation="$(cat navigation.html)" \
  -V footer="$(cat footer.html)"\
  -V year="$(date +%Y)"

# cp _index.md generatedindex.md
rm -f _index.md

