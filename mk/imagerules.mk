# General rules for making images

%.pdf: %.eps
	epstopdf $< > $@

%.eps: %.dot
	dot -Tps < $< > $@

%.pdf: %.svg
	inkscape -A $@ $<

%.eps: %.plt
	pyxplot $<

%.eps: %.dia
	dia -e $@ -t eps $<

#%.pdf: %.dot
#	dot -Tpdf < $< > $@

#%.svg: %.dot
#	dot -Tsvg < $< > $@

