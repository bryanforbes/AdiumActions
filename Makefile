VERSION = 0.91
WORKFLOW = AdiumActions-$(VERSION).alfredworkflow
WORKFLOW_FILES = adium.scpt icon.png info.plist update.json
DISTFILES = $(WORKFLOW) latest.json index.html
CLEANFILES = adium.scpt update.json
DISTCLEANFILES = $(CLEANFILES) $(DISTFILES)
VERSION_SUB = sed -e "s/{VERSION}/$(VERSION)/g"

all: $(WORKFLOW_FILES)

clean:
	rm -f $(CLEANFILES)

dist: $(DISTFILES)

distclean:
	rm -f $(DISTCLEANFILES)

adium.scpt:
	osacompile -o $@ adium.applescript

%.html: %.html.in
	$(VERSION_SUB) $^ > $@

%.json: %.json.in
	$(VERSION_SUB) $^ > $@

$(WORKFLOW): $(WORKFLOW_FILES)
	zip -q $@ $^

install: $(WORKFLOW)
	open $<

.PHONY: all clean dist distclean install
