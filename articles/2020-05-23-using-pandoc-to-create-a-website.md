---
title: Using Pandoc to create a Website
author: Jilles van Gurp
published: true
description: Overview of how to use pandoc to create personal website + blog.
tags: pandoc, static website, html, markdown
---

A version of this article was also published on [dev.to](https://dev.to/jillesvangurp/using-pandoc-to-create-a-website-1gea).

I think I created my first web page around 1997. I was studying at the University of Utrecht at the time. There was a brief period  around 1994 where the using the World Wide Web meant queueing for the single unix terminal with a gateway to the internet & Mosaic installed after lectures. This of course soon escalated. By 1997, all computer lab terminals (a mix of Sun and HP unix machines, and later some windows PCs) had a browser. It was around then that I put up a little HTML page on the faculty web server announcing my presence to the world.

In the years after, this thing migrated to different places and around 2002 I registered my domain [jillesvangurp.com](https://www.jillesvangurp.com)  (I was already too late to register jilles.com). Around the same time, I got into blogging. First with something called pivot, which I swapped out for Wordpress a couple of years later. For the past 16 or so years I've been using that to host my website. Recently, somebody pointed out that my web page was broken. Basically, my hosting provider did some infrastructure changes and this messed up https & http. Kind of embarrassing and it annoyed me that I had to spend time on fixing it.

So, I decided that enough was enough and it was time to retire Wordpress. This had been on my TODO list probably for the last five years or so. But it was one of those things that I never got around to. Over time, I've grown more uncomfortable with the notion of running a mess of php that is regularly in need of security updates and generally a vector for having your website defaced. Also, I like to write in markdown and Wordpress seems to insist on not storing that natively and/or mangling it.

After a survey of different tools for static website generation, I decided to keep it simple. There are a lot of these tools out there but they all seem to be a combination of opinionated and convoluted for what I want. And I got annoyed with their documentation. A problem I see with this type of tools is that the happy path of using them is well documented but basically only does less than half the job that you need done. Piecing the rest together has about the same complexity as just rolling your own scripts.

So, I picked the simplest tool that gets the job done: `pandoc`. Pandoc is a nice command-line tool to convert different text file formats to other formats. I've used a few months ago on my [Elasticsearch Kotlin Client](https://github.com/jillesvangurp/es-kotlin-wrapper-client/) to generate an [epub](https://github.com/jillesvangurp/es-kotlin-wrapper-client/blob/devtoarticle/book.epub) version of the manual. Crucially, it supports the Github flavor of markdown as input and html5 as the output. Even better, it can process code samples, do syntax highlighting, and some simple templating. That's all I need. I can do the rest with bash.

So, I started hacking a few bash scripts together that I've been adding features to in the last weeks. At this point, it's good enough for what I need. Of course the whole set up is highly tailored to my needs but that might be good enough for others as well. So, I decided to share the [source code on Github](https://github.com/jillesvangurp/www.jillesvangurp.com). If not, the scripts are simple enough to figure out that you can probably fix it to do whatever you need. Feel free to fork and adapt.

## Code

Here's a [script](https://github.com/jillesvangurp/www.jillesvangurp.com/blob/devtoarticle/pd-pages.sh) that I wrote to convert markdown:

```bash
#! /usr/bin/env bash
for page in $(ls pages); do
  pandoc --from markdown_github+smart+yaml_metadata_block+auto_identifiers "pages/$page" \
    -o "public/$(basename $page .md).html" \
    --template templates/page.html\
    -V navigation="$(cat navigation.html)" \
    -V footer="$(cat footer.html)"
done
```

This simply generates html for each of the pages in the pages directory and uses the [page.html](https://github.com/jillesvangurp/www.jillesvangurp.com/blob/devtoarticle/templates/page.html) template. This in turn has a few variables that it mostly gets from the markdown meta data section and I've added a few on the command line. Nice and simple.

I have a similar script that processes articles that I migrated from my old Wordpress setup (in the `articles` directory). Fixing the exported markdown was hard as Wordpress export makes a mess of that. But I got it done in the end with a lot of patience (and some regex replacing).

Since running the above script takes quite long on 300+ articles, I created [another script](https://github.com/jillesvangurp/www.jillesvangurp.com/blob/devtoarticle/pd-articles.sh) with a bit of hackery to fork processes with bash:

```bash

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
```

Note it has a little `&` on the `pandoc` command. This causes bash to fork a process. Then after all processes are forked, I wait for all the jobs to finish. Takes about 10 seconds to process everything. Good enough. 

Also note the `-V` options for setting variables, those are used in the template. In this case, I've added the publication date, which is parsed from the file name using grep.

For the [sitemap](https://github.com/jillesvangurp/www.jillesvangurp.com/blob/devtoarticle/sitemap.sh), I simply gobbled together some nice `find` command and a few `echo` commands.

```bash
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
```

I also needed an [index page](https://github.com/jillesvangurp/www.jillesvangurp.com/blob/devtoarticle/indexgenerator.sh) for my articles:

```bash
#! /usr/bin/env bash
rm -f _index.md
export HEADER=`cat <<EOF
---
title: Article Index
author: Jilles van Gurp
---

Intro text omitted ...
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
```

This is the most complicated script so far; mainly because I wanted to support the old Wordpress link structure of `year/month/day/title` so as to not break external URLs. I have an [.htaccess](https://github.com/jillesvangurp/www.jillesvangurp.com/blob/devtoarticle/.htaccess) file with some redirects.

There's [another very similar script](https://github.com/jillesvangurp/www.jillesvangurp.com/blob/devtoarticle/atom.sh) that generates an atom feed for those people still using feed readers. I used atom for mostly nostalgic reasons as I was following the standardization of that while I was in Nokia Research. I think RSS sort of stayed more dominant and then both are sort of equally irrelevant nowadays. But it's still around and I guess they are still uses by various news aggregators so having a feed probably is a good idea from an SEO perspective.

Finally, I have a [Makefile](https://github.com/jillesvangurp/www.jillesvangurp.com/blob/devtoarticle/Makefile) that invokes all my little scripts in the right order and all the output goes to a public folder. The last step uses rsync to copy everything over to my hosting provider. The whole process takes about 30 seconds; which is a bit on the slow side but acceptable.

## Conclusion

Is this setup better than other tools? Probably not. But I have full control over what happens and it's simple enough that I can use and maintain it. It's good enough for me; and it gets the job done.

Note, I've added links to the actual files in my git repo. Inevitably, there will be changes on master but all the links point to a tag created for this article.