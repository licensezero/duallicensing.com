YAML=node_modules/.bin/js-yaml
EJS=node_modules/.bin/ejs

all: index.html

index.html: data.sorted.json index.template.html | $(EJS)
	$(EJS) -o $@ -f $^
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
