#! /usr/bin/env bash
for blogpost in $(ls _posts); do 
  pandoc --from markdown_github+smart+yaml_metadata_block+auto_identifiers "_posts/$blogpost" -o "public/$(basename $blogpost .md).html" --template templ.html	
done

