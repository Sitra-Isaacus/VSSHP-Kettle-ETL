#!/bin/bash

# Author(s) : Arho Virkki
# Copyright : VTT Technical Reseach Centre of Finland
# Date      : 2015-10-29

#
# A simple tool for comparing headers
#

if [ $# -ne 2 ]
then 
  echo "# Please provide the directory containing the text files, with the headers"
  echo "# in the fist line, as the first argument, and the line of the header as second"
  echo "#"
  exit 0
fi

FPATH=$1
for infile in `ls $FPATH`
do
  head -n $2 $FPATH$infile | tail -n 1
done | less -S
