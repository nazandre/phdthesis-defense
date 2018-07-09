.PHONY: all clean realclean

MAIN_FILE_NAME = andre-naz-phdthesis-defense
BIBFILE = thesis.bib
EXTRA_FILES = $(wildcard src/*.tex) femtostslides.sty

COMPRESSION_SETTINGS = default
# screen   (screen-view-only quality, 72 dpi images)
# ebook    (low quality, 150 dpi images)
# printer  (high quality, 300 dpi images)
# prepress (high quality, color preserving, 300 dpi imgs)
# default  (almost identical to /screen)

all: $(MAIN_FILE_NAME)-cmp.pdf

# -pdf tells latexmk to generate PDF directly (instead of DVI).
# -pdflatex="" tells latexmk to call a specific backend with specific options.
# -use-make tells latexmk to call make for generating missing files.
# -interactive=nonstopmode keeps the pdflatex backend from stopping at a
# missing file reference and interactively asking you for an alternative.

$(MAIN_FILE_NAME).pdf: $(MAIN_FILE_NAME).tex $(EXTRA_FILES) $(BIBFILE)
	latexmk -pdf -pdflatex="pdflatex -interactive=nonstopmode" -use-make $<

$(MAIN_FILE_NAME)-cmp.pdf: $(MAIN_FILE_NAME).pdf
	gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/$(COMPRESSION_SETTINGS) -sOutputFile=$@ $<

clean:
	rm -f *.aux *.log *.fls *.bbl *.blg *.synctex.gz *.fdb_latexmk *.toc *~ *.snm *.out *.nav

realclean: clean
	rm -f $(MAIN_FILE_NAME).pdf $(MAIN_FILE_NAME)-cmp.pdf
