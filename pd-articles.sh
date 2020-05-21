#! /usr/bin/env bash
export navigation=$(cat navigation.html)

for blogpost in $(ls wordpress-articles); do 
  pandoc --from markdown_github+smart+yaml_metadata_block+auto_identifiers "wordpress-articles/$blogpost" \
    -o "public/blog/$(basename $blogpost .md).html" \
    --template templates/article.html	\
    -V year="$(date +%Y)" \
    -V navigation="$navigation" &
done
for pid in $(jobs -p); do
    wait $pid
done
find public/blog | wc -l
