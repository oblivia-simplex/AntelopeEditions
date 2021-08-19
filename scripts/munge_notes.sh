#! /usr/bin/env bash

function munge() {

  filename="$1"
  stem="${filename%.*}"

  sed -i'.bak' "s/\[\^\([*0-9a-zA-Z_][*0-9a-zA-Z_]*\)\]/[^${stem}_\1]/g" ${filename}
  mv *.bak build/

}

for m in $* ; do
  (grep -q "${m%.*}" "$m" && echo "Already did $m") && continue
  grep -q '\[\^' "$m" || continue
  echo "Munging notes in $m" && munge $1
done
