.DEFAULT_GOAL := all

.PHONY: clean
clean:
	rm -rf public

.PHONY: public
public:
	mkdir public
	./pd.sh

.PHONY: all
all: clean public
	


