#! /usr/bin/env bash

feedbegin=`cat <<EOF
<?xml version="1.0" encoding="utf-8"?>

<feed xmlns="http://www.w3.org/2005/Atom">
  <id>https://www.jillesvangurp.com/atom.xml</id>
	<title>Jilles van Gurp's blog</title>
	<link href="https://www.jillesvangurp.com/atom.xml" rel="self" />
	<link href="https://www.jillesvangurp.com/" />
	<updated>2003-12-13T18:30:02Z</updated>
EOF
`

echo "$feedbegin" > public/atom.xml
printf "\n" >> public/atom.xml

for name in $(find articles -type f -exec basename {} \; | sort -ur | sed 's/\.md//' | head -n 20); do
  year=$(echo $name | sed -E 's/([0-9]{4})-([0-9]{2})-([0-9]{2})-(.*)/\1/')
  month=$(echo $name | sed -E 's/([0-9]{4})-([0-9]{2})-([0-9]{2})-(.*)/\2/')
  day=$(echo $name | sed -E 's/([0-9]{4})-([0-9]{2})-([0-9]{2})-(.*)/\3/')
  title=$(echo $name | sed -E 's/([0-9]{4})-([0-9]{2})-([0-9]{2})-(.*)/\4/')
  nice_title=$(echo "$year-$month-$day - $(echo ${title:0:1} | tr  '[a-z]' '[A-Z]' )${title:1}" | sed -e 's/-/ /g')
  link="https://www.jillesvangurp.com/$year/$month/$day/$title"
  head -n 17 articles/$name.md| pandoc -f markdown -t html5 \
    --template templates/atom-entry.xml \
    -V link=$link \
    -V timestamp="${year}-${month}-${day}T12:00:00Z" >> public/atom.xml 
  printf "\n" >> public/atom.xml
done

echo "</feed>" >> public/atom.xml
