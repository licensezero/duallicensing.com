YAML=node_modules/.bin/js-yaml

all: index.html

index.html: data.sorted.json index.template.html | node_modules
	node_modules/.bin/mustache $^ > $@
	tidy -config tidy.config $@ | sponge $@

data.sorted.json: data.json
	./sort < $< > $@

data.json: data.yml | $(YAML)
	$(YAML) $< > $@

node_modules:
	npm ci

.PHONY: clean

clean:
	rm -f index.html
