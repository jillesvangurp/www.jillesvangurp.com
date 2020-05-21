#! /usr/bin/env bash
rm -f _index.md
export HEADER=$(cat <<EOF
---
title: Article Index
author: Jilles van Gurp
---

This is a list of all articles on this website. Most of these used to be part of a wordpress site. These days, I use a static site generator.

Note, I migrated these articles at some point. I tried to clean it up but wordpress evolved quite a bit over the past 20+ years. So there are utf-8 encoding errors that may have slipped in, broken links, bits of information that are no longer relevant/outdated, etc. I decided to preserve this and not break any links.
EOF
)


echo "$HEADER" > _index.md
echo "" >> _index.md

for name in $(find articles -type f -exec basename {} \; | sort -ur | sed 's/\.md//'); do
  year=$(echo $name | sed -E 's/([0-9]{4})-([0-9]{2})-([0-9]{2})-(.*)/\1/')
  month=$(echo $name | sed -E 's/([0-9]{4})-([0-9]{2})-([0-9]{2})-(.*)/\2/')
  day=$(echo $name | sed -E 's/([0-9]{4})-([0-9]{2})-([0-9]{2})-(.*)/\3/')
  title=$(echo $name | sed -E 's/([0-9]{4})-([0-9]{2})-([0-9]{2})-(.*)/\4/')
  echo "- [$year-$month-$day $(echo ${title:0:1} | tr  '[a-z]' '[A-Z]' | sed -e 's/-/ /g')${title:1}](/$year/$month/$day/$title)" >> _index.md

done

pandoc --from markdown_github+smart+yaml_metadata_block+auto_identifiers "_index.md" -o "public/blog/index.html" --template templates/article.html -V year="$(date +%Y)"

rm -f _index.md

