# www.jillesvangurp.com

Source code & markdown for generating my [website](https://www.jillesvangurp.com). I use pandoc and a bit of bash to generate the site.

Feel free to copy and adapt as you need. This bunch of scripts that I have is deliberately kept minimal and simple. Yet, I'm of course looking to add features over time.

## Features

- Uses pandoc to render github flavored markdown. I exported my old wordpress articles to markdown format and did a lot of manual cleanup.
- Can be used to render code blocks as well
- Sitemap, article index, and recent articles are generated.
- Atom feed is generated for the articles.
- Css minifier.

## Usage

```bash
# create docker container with tools and scripts
make docker
# build the site
make all
# check if you like what it did
# you might want to tweak the Makefile to update where and how you deploy before you run this. Uses rsync.
make deploy
```

## Directories and files

- `articles` this is where you put your blog articles. Use an iso date as the name prefix so it gets sorted correctly.
- `docker` this is where all the scripts and the Dockerfile live.
- `pages` this is where the markdown for each of the pages live.
- `wp-content` as the name suggests this has all the file uploads from my former wordpress blog. Those are linked from the articles.
- `static` this is the static part of my website. Some of it dates back to last century. It's copied over as is
- `public` this directory is git ignored and is where the generated files end up
- `templates` put your pandoc templates here
- `footer.html` and `navigation.html` little hard coded navigation that is injected in the template. Nice and simple.
- `style.css` put your styling here. It all gets minified as part of the scripts.
- `Makefile` mostly self explanatory. You might want to tweak the hard coded values

## License

The scripts & css are MIT licensed. The Markdown & website content is NOT and the copyright belongs to me. This means normal copyright law applies to that (i.e. don't republish my website without my permission).

