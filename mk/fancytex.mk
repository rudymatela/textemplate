# Fancy tex implicit rules
# for a simpler version, see tex.mk

# configure custom output quieter quiet
TOP ?= .
export PATH := $(PATH):$(TOP)/bin
export QUIETPREFIX ?= tmp/
QUIET        = quiet
# If you have moreutils installed,
#   you can use chronic instead of the three lines above:
# QUIET        = chronic </dev/null

PDFLATEX     = $(QUIET) pdflatex -halt-on-error -file-line-error -output-directory tmp
FASTPDFLATEX =          $(PDFLATEX) -draftmode
HASBIB       =          grep -q '^\\bibdata{.*}$$'
BIBTEX       = $(QUIET) bibtex

%.pdf: %.tex
	@mkdir -p tmp
	$(FASTPDFLATEX) $<
	if $(HASBIB) tmp/$*.aux; then \
	  $(BIBTEX) tmp/$* && \
	  $(FASTPDFLATEX) $<; \
	fi
	$(PDFLATEX) $<
	@cp tmp/$@ $@

%-handout.pdf: %.tex
	@mkdir -p tmp
	$(FASTPDFLATEX) -jobname $*-handout $<
	if $(HASBIB) tmp/$*-handout.aux; then \
	  $(BIBTEX) tmp/$*-handout && \
	  $(FASTPDFLATEX) -jobname $*-handout $<; \
	fi
	$(PDFLATEX) -jobname $*-handout $<
	@cp tmp/$@ $@

cleanauxs:
	rm -rf tmp/
