#!/bin/bash

# Author(s) : Arho Virkki
# Copyright : VTT Technical Reseach Centre of Finland
# Date      : 2015-10-29

FPATH="/opt/share/raw/lab/"
TABLE="lab"

time for infile in `ls $FPATH`
do
	echo "# Adding partition for "$infile
 	etl_add_partition.R $TABLE $infile
done

