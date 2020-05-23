#! /usr/bin/env bash
rm -f _index.md
export HEADER=`cat <<EOF
---
title: Article Index
author: Jilles van Gurp
---

I used to have a wordpress blog and before that, I used something called pivot. These days I use a simple static site generator (pandoc) with some home grown scripts and templates. I tried to preserve the articles and link structure when I migrated the content to markdown. There is about 2 decades worth of content here. Most of it no longer relevant of course. But I decided to preserve it.

In recent years, I've published articles on platforms like [medium](https://medium.com/@jillesvangurp_30276) and [dev.to](https://dev.to/jillesvangurp) and I've also added most of that content here. I'll likely continue to add more articles. Part of my reasons to migrate to a static website was so I can start adding content again.

Note: I tried to clean up the migrated content but wordpress evolved quite a bit over the past 20+ years. So there are utf-8 encoding errors that may have slipped in, broken links to websites that no longer exist, bits of information that are no longer relevant/outdated/wrong, etc. If you notice something fixable, let me know. Otherwise enjoy.
EOF
`

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

pandoc --from markdown_github+smart+yaml_metadata_block+auto_identifiers "_index.md" \
  -o "public/blog/index.html" \
  --template templates/article.html \
  -V navigation="$(cat navigation.html)" \
  -V footer="$(cat footer.html)"\
  -V year="$(date +%Y)"

# cp _index.md generatedindex.md
rm -f _index.md

