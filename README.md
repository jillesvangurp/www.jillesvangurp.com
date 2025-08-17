# www.jillesvangurp.com

Source code and markdown for generating my [website](https://www.jillesvangurp.com).

Everything is built with shell scripts, make, and [Pandoc](https://pandoc.org).

Feel free to copy and adapt as you need; this setup is deliberately minimal.

## Key features

- Markdown articles and pages rendered with Pandoc templates
- Syntax highlighting for fenced code blocks
- Automatic sitemap, blog index, recent posts list and Atom feed
- Tailwind CSS styling with minified output
- Shell scripts launch sub processes to speed things up.
- Uses docker to remove the need to install a lot of tools.

## Tool chain

All tooling runs inside a Docker container so nothing (except for docker) needs to be installed locally.

- **Pandoc** for converting Markdown to HTML
- **Node.js** tooling for PostCSS and Tailwind CSS
- **Tailwind CLI** and **PostCSS** with `autoprefixer` to build CSS
- **minify** for shrinking the final CSS bundle
- Small bash scripts and a Makefile orchestrate the build

## Usage

Build the container and generate the site:

```bash
make docker    # build the container with the tool chain
make all       # generate the site into public/
```

Deploying is project specific. Adjust the `deploy` target in the Makefile
and run:

```bash
make deploy
```

## Directory structure

- `Makefile`     build and deployment targets
- `articles/`    blog articles named `YYYY-MM-DD-title.md`
- `docker/`      Dockerfile and build scripts
- `pages/`       standalone markdown pages
- `static/`      static files copied as-is
- `templates/`   Pandoc templates and partials
- `wp-content/`  legacy uploads referenced from articles
- `public/`      generated output (ignored in git)
- `navigation.html` and `footer.html` snippets injected in pages
- `tailwind.css`, `postcss.config.js`, `tailwind.config.js` styling sources

## License

The scripts and CSS are MIT licensed.

Website content and markdown are copyrighted and may not be republished without permission.

