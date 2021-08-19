#! /usr/bin/env bash


EPUB=`readlink -f $1`
shift
FILES="$*"

d=`mktemp -d`

unzip -d $d $EPUB
for f in $FILES; do
    id=`sed "s|\.|_|g" <<< "$f"`
    base=`basename $f`
    mimetype=`file -b --mime-type $f`
    cp -v $f $d/EPUB/media/
    sed -i "s|</manifest>|  <item id=\"$id\" href=\"media/$base\" media-type=\"$mimetype\" />\n  </manifest>|" \
        $d/EPUB/content.opf
done
cd $d
zip -r $EPUB .
rm -rf $d

