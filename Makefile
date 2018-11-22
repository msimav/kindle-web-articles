SRC  = src
DIST = dist

JQ        = jq
CURL      = curl
PANDOC    = pandoc
KINDLEGEN = kindlegen

mobi: $(DIST) $(DIST)/book.mobi
epub: $(DIST) $(DIST)/book.epub

ifndef MERCURY_KEY
$(error Please export MERCURY_KEY to continue)
endif

$(DIST)/%.json: $(SRC)/%.url
	$(CURL) -sfS -H "x-api-key: $(MERCURY_KEY)" -o $@ "https://mercury.postlight.com/parser?url=$(shell cat $^)"

$(DIST)/%.md: $(DIST)/%.json
	$(JQ) -r '"# \(.title)\n\n"' $^ > $@
	$(JQ) -r .content $^ | $(PANDOC) -f html -t markdown_strict >> $@

$(DIST)/book.epub: $(shell ls $(SRC)/*.url | sed 's:$(SRC)\(.*\).url:$(DIST)\1.md:g')
	$(PANDOC) --toc --toc-depth=1 --epub-chapter-level=1 -o $@ title.txt $(sort $^)

$(DIST)/book.mobi: $(DIST)/book.epub
	$(KINDLEGEN) $^ || true

$(DIST):
	mkdir -p $(DIST)

clean-all: clean
	rm -f $(SRC)/*.url

clean:
	rm -rf $(DIST)

.PHONY: mobi epub clean clean-all

ifdef DEBUG
.PRECIOUS: $(DIST)/%.json
endif

