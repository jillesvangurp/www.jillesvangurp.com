.DEFAULT_GOAL := all

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
	./pd-pages.sh

.PHONY: blogindex
blogindex:
	./indexgenerator.sh

.PHONY: blog
blog: blogindex
	./pd-articles.sh

.PHONY: es-kotlin-manual
es-kotlin-manual:
	./pd-es-kotlin.sh

.PHONY: run
run:
	docker run -dit --name jilles-httpd -p 8080:80 -v "$(shell pwd)/public":/usr/local/apache2/htdocs/ httpd

.PHONY: stop
stop:
	docker kill jilles-httpd

.PHONY: minify
minify:
	# https://github.com/tdewolff/minify/tree/master/cmd/minify
	minify style.css -o public/style.css

.PHONY: sitemap
sitemap:
	./sitemap.sh

.PHONY: atom
atom:
	./atom.sh

.PHONY: deploy
deploy:
	rsync -azp --delete-after  public/* jillesvangurpcom@ftp.jillesvangurp.com:/srv/home/jillesvangurpcom/domains/jillesvangurp.com/htdocs/www
	rsync -azp --delete-after  public/.htaccess jillesvangurpcom@ftp.jillesvangurp.com:/srv/home/jillesvangurpcom/domains/jillesvangurp.com/htdocs

.PHONY: all
all: clean pages blog es-kotlin-manual sitemap atom minify
	


