.DEFAULT_GOAL := all

.PHONY: clean
clean:
	rm -rf public

.PHONY: public
public:
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

.PHONY: run
run:
	docker run -dit --name jilles-httpd -p 8080:80 -v "$(shell pwd)/public":/usr/local/apache2/htdocs/ httpd

.PHONY: stop

stop:
	docker kill jilles-httpd

.PHONY: deploy
deploy:
	rsync -azp --delete-after  public/* jillesvangurpcom@ftp.jillesvangurp.com:/srv/home/jillesvangurpcom/domains/jillesvangurp.com/htdocs/www
	rsync -azp --delete-after  public/.htaccess jillesvangurpcom@ftp.jillesvangurp.com:/srv/home/jillesvangurpcom/domains/jillesvangurp.com/htdocs

.PHONY: all
all: clean public blog
	


