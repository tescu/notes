#!/usr/bin/env bash

# Clean directory
[ -f "index.html" ] && rm *.html

# Write note posts:
for f in note/*.md; do
	# Grab filename and title
	file="$(basename $f)"
	notetitle="$(sed '2q;d' $f | sed 's/title: //;s/\"//g')"
	notefile=${file%.md}.html

	printf "%s\n" "Creating ${f%.md}.html ($notetitle)..."
	# Append to list:
	notelist="$notelist<li><a href="$notefile">$notetitle</a><br/>$file</li>"

	# Content
	pandoc -s --toc --template=tmp/blank.html "$f" >> "$notefile"
done

# Write index.html
cat > index.html << EOF
<!DOCTYPE html>
<html><head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>notes - negoitescu</title>
  <link href="./style.css" rel="stylesheet" type="text/css" media="all">
</head><body><div id="main">
  <h1>notes</h1>
  <ul>
  $notelist
  </ul>
  <hr/>
  <p>Hosted by <a href="https://github.com/tescu/notes">GitHub</a>. All notes available here are licensed under the <a href="https://www.creativecommons.org/licenses/by-nc/4.0/deed.en">CC BY-NC 4.0</a>, unless otherwise noted.</p>
</div></body>
</html>
EOF

