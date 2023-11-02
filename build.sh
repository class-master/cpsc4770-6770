#!/bin/bash
 
 rm -Rf _build
source activate jupyter-book
jupyter-book build .

if [[ $1 == "pages" ]]
then
  git add .
  git commit -m "update $(date)"
  git push
  ghp-import -n -p -f _build/html
fi
