#!/bin/bash

# Author(s)     : Arho Virkki
# Copyright     : VTT Technical Reseach Centre of Finland Ltd
# Original date : 2016-02-03


TARGET_DIRECTORY="./schema_backups"
IDENTIFIER="_ktppg.sql.bz2"
FILE_NAME=`date --rfc-3339="date"`$IDENTIFIER
echo "# Dumping current database schema into:"
echo "# "$TARGET_DIRECTORY"/"$FILE_NAME

touch $TARGET_DIRECTORY"/"$FILE_NAME
pg_dump --schema-only -U ktp -h ktppg.vsshp.net | bzip2 >  $TARGET_DIRECTORY"/"$FILE_NAME

# Chech whether the new dump differs from the previous one
two_latest_files=`ls $TARGET_DIRECTORY"/"*$IDENTIFIER* | tail -2`

nfiles=$(echo $two_latest_files | wc -w)
if [ $nfiles == 2 ]
then 
	if diff $two_latest_files  >/dev/null ; 
	then
		# The files did not differ
		echo "# "
		echo "# There was no difference between this and the previous schema."
		echo "# Automatically removing the redundant file."
		rm $TARGET_DIRECTORY"/"$FILE_NAME
		echo "# "
		echo "# The latest is still:"
		echo "# "`ls $TARGET_DIRECTORY"/"*$IDENTIFIER* | tail -1`
	else
		# The new dump was different
		echo "# The new schema dump contains changes as compared to the previous one."
	fi
fi

echo "# Done."
