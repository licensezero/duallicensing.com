.PHONY: all clean

all: index.html

index.html: data.sorted.json index.template.html | node_modules
	node_modules/.bin/mustache $^ > $@
	tidy -config tidy.config $@ | sponge $@

data.sorted.json: data.json
	./sort < $< > $@

node_modules:
	npm ci

clean:
	rm -f index.html
