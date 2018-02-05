#!/bin/bash

# Re-define hive table

# Author(s) : Arho Virkki
# Copyright : VTT Technical Reseach Centre of Finland
# Date      : 2015-11-27

if [ $# -lt 1 ]
then
  echo "# Please provide the table name as the first argument."
  echo "# Example: "`basename $0`" lab_codetables"
  echo "#"
  exit 0
else
  FOLDER=$1
fi

beeline -u jdbc:hive2://localhost:10000/ktp -e '!run '$ETL_TABLE_SCRIPTS/$FOLDER/'hive_table.sql'

# Check whether we need to re-create the partitions
grep -q -ei "partitioned" $ETL_TABLE_SCRIPTS/$FOLDER/'hive_table.sql'
if [ $? ]
then 
  etl_update_partitions.R $FOLDER
fi
