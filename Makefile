EXTENSION_FILES = adium.scpt icon.png info.plist
EXTENSION = AdiumActions.alfredextension

all: $(EXTENSION)

adium.scpt:
	osacompile -o $@ adium.applescript

$(EXTENSION): $(EXTENSION_FILES)
	zip -q $@ $^

clean:
	rm -f adium.scpt $(EXTENSION)

install: $(EXTENSION)
	open $<

.PHONY: all clean install
