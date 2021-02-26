.PHONY: all

all: index.html

index.html: data.sorted.json index.template.html
	npx mustache $^ > $@
	tidy -config tidy.config $@ | sponge $@

data.sorted.json: data.json
	./sort < $< > $@
