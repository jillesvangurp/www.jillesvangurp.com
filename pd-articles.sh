#! /usr/bin/env bash

for blogpost in $(ls articles); do 
  export publishdate=$(echo $blogpost | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}')
  pandoc --from markdown_github+smart+yaml_metadata_block+auto_identifiers "articles/$blogpost" \
    -o "public/blog/$(basename $blogpost .md).html" \
    --template templates/article.html	\
    -V publishdate="$publishdate" \
    -V navigation="$(cat navigation.html)" \
    -V footer="$(cat footer.html)"&
done
for pid in $(jobs -p); do
    wait $pid
done
find public/blog | wc -l
