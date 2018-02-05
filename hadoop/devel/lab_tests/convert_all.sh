#!/bin/bash

# Author(s) : Arho Virkki
# Copyright : VTT Technical Reseach Centre of Finland
# Date      : 2015-10-29

FPATH="/opt/share/raw/lab/"

time for infile in `ls $FPATH`
do
	echo "# Converting "$infile
	time ./convert.sh $infile
done

