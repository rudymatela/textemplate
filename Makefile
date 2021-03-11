# Makefile from textemplate

export TEXINPUTS ?= .:./sty:

FIGS=fig/graph.pdf fig/watermark.pdf fig/diagram.pdf fig/euler.pdf
TARGETS=paper.pdf talk.pdf talk-handout.pdf graph-paper.pdf


all: $(TARGETS)

paper.pdf: paper.tex bibliography.bib $(FIGS)

talk.pdf: talk.tex $(FIGS)

talk-handout.pdf: talk.tex $(FIGS)

graph-paper.pdf: graph-paper.tex

.PHONY: figs
figs: $(FIGS)


.PHONY: clean cleanauxs cleanfigs
clean: cleanauxs cleanfigs
	rm -f $(TARGETS)

cleanfigs:
	rm -f $(FIGS)


# Includes
# Keep those at the end: even if they define explicit rules, they won't take
# over the default rule ("all").

include mk/imagerules.mk
include mk/fancytex.mk # optionally, the simpler mk/tex.mk
