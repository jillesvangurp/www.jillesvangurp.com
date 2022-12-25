#! /usr/bin/env bash
sitemap="public/sitemap.xml"
baseurl="https://www.jillesvangurp.com"
timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

function url() {
  echo "<url><loc>${baseurl}/$1<loc><lastmod>$timestamp</lastmod></url>"
}

robots=`cat <<EOF
User-agent: *
Allow: *
Sitemap: $baseurl/sitemap.xml

EOF
`
echo "$robots" > public/robots.txt

header=`cat <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
EOF
` 
echo "$header" > $sitemap

for file in $(find public -name "*.html" | sed -e 's/public\///'); do
  echo $(url $file) >> $sitemap
done

printf "</urlset>\n" >> $sitemap