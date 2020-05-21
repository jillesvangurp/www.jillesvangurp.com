#! /usr/bin/env bash
mkdir -p public/es-kotlin-manual
for article in $(ls ../es-kotlin-wrapper-client/manual); do 
  export title=$(echo "$article" | sed -e 's/.md//' | sed -e 's/-/ /g')
  export title="$(echo ${title:0:1} | tr  '[a-z]' '[A-Z]')${title:1}"
  export output="public/es-kotlin-manual/$(basename "$article" .md).html"
  pandoc --from markdown_github+smart+yaml_metadata_block+auto_identifiers \
        "../es-kotlin-wrapper-client/manual/$article" \
        -o "$output" \
        --template templates/kotlin-manual.html	\
        -V year="$(date +%Y)" \
        -V navigation="$(cat navigation.html)" \
        -V footer="$(cat footer.html)" \
        --metadata title="$title" \
        --metadata author="Jilles van Gurp"
  sed -i ' ' 's/\.md/\.html/g' "$output"
done
