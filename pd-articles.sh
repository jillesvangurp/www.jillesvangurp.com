#! /usr/bin/env bash
for blogpost in $(ls wordpress-articles); do 
  pandoc --from markdown_github+smart+yaml_metadata_block+auto_identifiers "wordpress-articles/$blogpost" -o "public/blog/$(basename $blogpost .md).html" --template templates/article.html	
done
