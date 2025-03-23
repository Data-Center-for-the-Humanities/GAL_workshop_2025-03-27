## Markdown extension (e.g. md, markdown, mdown).
MEXT = md

## All markdown files in the working directory
SRC = $(wildcard *.$(MEXT))

IMG=./img/

PDFS=$(SRC:.md=.pdf)
HTML=$(SRC:.md=.html)
PPTX=$(SRC:.md=.pptx)

all:	$(PDFS) $(HTML) $(TEX) $(DOCX)

pdf:	$(PDFS)
html:	clean $(HTML)
pptx:	$(PPTX)

%.html: %.md qr.png metadata.png
	marp slides.md --theme ./css/dch.css -o slides.html

%.pdf: %.md qr.png metadata.png
	marp slides.md --theme ./css/dch.css -o slides.pdf  --allow-local-files;\
	mv slides.pdf ./pdf/

%.pptx: %.md qr.png metadata.png
	marp slides.md --theme ./css/dch.css -o slides.pptx  --allow-local-files;\
	mv slides.pptx ./pdf/

qr.png: slides.md
	echo "Searching for DOI in slides.md...";\
	grep "^doi: " slides.md | awk -F '[ ]' '{print $2}' | qrencode --margin=0 --dpi=300 -o qr.png;\
	mv qr.png ./img/

metadata.png: $(IMG)blam.png $(IMG)zenodo.png
	magick $(IMG)blam.png $(IMG)zenodo.png -append metadata.png;\
	mv metadata.png ./img/

clean:
	rm -f slides.html ./pdf/slides.pdf

.PHONY: clean