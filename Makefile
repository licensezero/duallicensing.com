.PHONY: all

all: index.html tidy.config
	tidy -config tidy.config $< | sponge $<
