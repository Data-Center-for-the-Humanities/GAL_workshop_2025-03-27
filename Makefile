slides.html: slides.md qr.png
	marp slides.md --theme ./css/dch.css -o slides.html

qr.png: slides.md
	echo "Searching for DOI in slides.md..."
	grep "^doi: " slides.md | awk -F '[ ]' '{print $2}' | qrencode -o qr.png
	mv qr.png ./img/

.PHONY: clean
clean:
	rm -f slides.html slides.pdf