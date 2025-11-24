#!/usr/bin/env bash
# Clean directory
[ -f "index.html" ] && rm *.html
export list=""
# Write note posts:
for f in write/*.md; do
	# Grab filename and title
	file="$(basename $f)"
	ntitle="$(sed '2q;d' $f | sed 's/title: //;s/\"//g')"
	nf="${file%.md}.html"

	printf "%s\n" "Creating $nf ($ntitle)..."
	# Append to list:
	export list="$list<li><a href="$nf">$ntitle</a><br/>${file%.md}</li>"

	# Content
	pandoc -s --toc --template=res/blank.html "$f" >> "$nf"
done

# Write index.html
envsubst < res/index.html > index.html

printf "%s\n" "Done!"
