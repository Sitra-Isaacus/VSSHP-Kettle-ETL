#!/bin/bash

# files to remove BOM from
FILES=/mnt/raw/aria/2016-04-19*.txt

# new directory
NEWDIR=/mnt/raw/aria/bom_removed/

#make directory for bom-removed files if it doesn't exist
#mkdir -p $NEWDIR
mkdir -p /mnt/raw/aria/bom_removed/

# process each file
for FILE in $FILES;
do
OUTFILE=$NEWDIR$(basename -s .txt $FILE)_bom_removed.txt
#echo $OUTFILE
#echo $(${NEWDIR}$(basename -s .txt $FILE)_bom_removed.txt) 
# remove UTF-8 BOM from line in $FILE and write to a new file with the suffix _bom_removed
awk 'NR==1{sub(/^\xef\xbb\xbf/,"")}{print}' $FILE >  $OUTFILE
done
