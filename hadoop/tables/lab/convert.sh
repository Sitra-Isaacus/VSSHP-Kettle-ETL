#!/bin/bash

# Lab data conversion script

# Author(s) : Arho Virkki
# Copyright : VTT Technical Reseach Centre of Finland
# Date      : 2015-10-23

TABLE="lab"
RAW=$ETL_RAW_REPOSITORY/$TABLE
DW=$ETL_HIVE_DW/$TABLE

if [ $# -lt 1 ]
then 
  echo "# Please provide the input file name as the first argument."
  echo "# Optionally, test' as the second argument for a dry run."
  echo "#"
	exit 0
else 
  FILE=$1
fi

echo "Converting "$FILE

# External Partitioned Table. The date -- stored as the first 10 
# characters of the file name -- is used for partitioning.
#
if [ "$2" != "test"  ]
then
  # Extract the date from the beginning of file
  PARTITION=$DW/${FILE:0:10}
  
	if [ ! -d $PARTITION ] 
	then
		mkdir -p $PARTITION
  fi
fi

cat $RAW/$1 | 

# Remove header
sed -e '1d' |

# Recode into UTF-8
recode ISO-8859-1..UTF-8 |

# Replace comma with dot in decimal numbers
perl -pe 's/(\d+),(\d+)/$1.$2/g' |

# Convert CRLF line endings (DOS) into LF line endings (linux). \r catches
# the carriage return
perl -pe 's/\r//g' |

# write to file or to screen is "test" argument is given 
if [ "$2" == "test"  ]
then
  eval " less -S "
else
  eval " cat > "$PARTITION/$FILE
fi
