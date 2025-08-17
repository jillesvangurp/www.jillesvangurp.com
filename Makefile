# Build the entire site by default
.DEFAULT_GOAL := all

# Run commands inside the sitegen container
export SITEGEN=docker run --rm -v $(shell pwd):/root sitegen

# Build the Docker image with the tool chain
.PHONY: docker
docker:
	docker build docker -t sitegen

# Remove generated output
.PHONY: clean
clean:
	rm -rf public

# Render markdown pages and copy static assets
.PHONY: pages
pages:
	mkdir -p public/blog
	# link so we can develop
	cp .htaccess public
	cp -R static public
	cp -R wp-content public
	$(SITEGEN) pd-pages.sh

# Generate the blog index page
.PHONY: blogindex
blogindex:
	$(SITEGEN) indexgenerator.sh

# Convert markdown articles to HTML
.PHONY: blog
blog: blogindex
	$(SITEGEN) pd-articles.sh

# Serve the site locally on port 8080
.PHONY: run
run:
	docker run -dit --rm --name jilles-httpd -p 8080:80 -v "$(shell pwd)/public":/usr/local/apache2/htdocs/ httpd

# Stop the local preview server
.PHONY: stop
stop:
	docker kill jilles-httpd

# Build and minify the CSS bundle
.PHONY: minify
minify:
	$(SITEGEN) postcss tailwind.css -o style.css

	rm -rf node_modules
	echo '```html' > sample.md
	echo "OHAI" >> sample.md
	echo '```' >> sample.md
	$(SITEGEN) pandoc --template=highlighting-css.template sample.md -o highlighting.css
	rm sample.md
	cat highlighting.css >> style.css
	$(SITEGEN) minify style.css -o public/style.css

# Generate sitemap.xml and robots.txt
.PHONY: sitemap
sitemap:
	$(SITEGEN) sitemap.sh

# Create the Atom feed
.PHONY: atom
atom:
	$(SITEGEN) atom.sh

# Upload the generated site to the server
.PHONY: deploy
deploy:
	rsync -azpv --exclude maven* --exclude bmath --delete-after  public/* jillesvangurpcom@ftp.jillesvangurp.com:/srv/home/jillesvangurpcom/domains/jillesvangurp.com/htdocs/www
	rsync -azpv --delete-after  public/.htaccess jillesvangurpcom@ftp.jillesvangurp.com:/srv/home/jillesvangurpcom/domains/jillesvangurp.com/htdocs

# Build everything
.PHONY: all
all: docker clean pages blog sitemap atom minify




