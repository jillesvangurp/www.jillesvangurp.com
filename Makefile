.DEFAULT_GOAL := all

export SITEGEN=docker run -v $(shell pwd):/root sitegen

.PHONY: docker
docker:
	docker build docker -t sitegen

.PHONY: clean
clean:
	rm -rf public

.PHONY: pages
pages:
	mkdir -p public/blog
	# link so we can develop
	cp style.css public
	cp .htaccess public
	cp -R static public
	cp -R wp-content public
	$(SITEGEN) pd-pages.sh

.PHONY: blogindex
blogindex:
	$(SITEGEN) indexgenerator.sh

.PHONY: blog
blog: blogindex
	$(SITEGEN) pd-articles.sh

.PHONY: run
run:
	docker run -dit --rm --name jilles-httpd -p 8080:80 -v "$(shell pwd)/public":/usr/local/apache2/htdocs/ httpd

.PHONY: stop
stop:
	docker kill jilles-httpd

.PHONY: minify
minify:
	# https://github.com/tdewolff/minify/tree/master/cmd/minify
	$(SITEGEN) minify style.css -o public/style.css

.PHONY: sitemap
sitemap:
	$(SITEGEN) sitemap.sh

.PHONY: atom
atom:
	$(SITEGEN) atom.sh

.PHONY: deploy
deploy:
	rsync -azpv --exclude maven* --exclude bmath --delete-after  public/* jillesvangurpcom@ftp.jillesvangurp.com:/srv/home/jillesvangurpcom/domains/jillesvangurp.com/htdocs/www
	rsync -azpv --delete-after  public/.htaccess jillesvangurpcom@ftp.jillesvangurp.com:/srv/home/jillesvangurpcom/domains/jillesvangurp.com/htdocs

.PHONY: all
all: clean pages blog sitemap atom minify




