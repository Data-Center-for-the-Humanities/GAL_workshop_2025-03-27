#!/bin/bash

# Check if the file exists
if [ ! -f "slides.md" ]; then
    echo "Error: slides.md not found" >&2
    exit 1
fi

# Check if qrencode is installed
if ! command -v qrencode &> /dev/null; then
    echo "Error: qrencode not found. Please install qrencode first." >&2
    exit 1
fi

# Extract the DOI URL and pipe to qrencode
DOI_URL=$(grep "^doi: " slides.md | awk -F '[ ]' '{print $2}')

# Check if we found a DOI
if [ -z "$DOI_URL" ]; then
    echo "Error: No DOI URL found in slides.md" >&2
    exit 1
fi

# Pipe the URL to qrencode
echo "$DOI_URL" | qrencode -o qr.png
