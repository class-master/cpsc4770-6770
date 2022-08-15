#!/bin/bash
 
 rm -Rf _build
source activate jupyter-book
jupyter-book build .

if [[ $1 == "docs" ]]
then
  rm -Rf docs
  mkdir docs
  rsync -a _build/html/ docs/
fi
