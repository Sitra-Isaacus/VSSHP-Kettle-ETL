#!/bin/bash

# Qpati data conversion script

# Author(s) : Arho Virkki
# Copyright : VTT Technical Reseach Centre of Finland
# Date      : 2015-10-23

PREVIEW_TAB_WIDTH=40

RAW="/opt/share/raw/qpati_2013/"
DW="/mnt/hdfs/user/hive/warehouse/ktp/qpati/"

if [ $# -lt 1 ]
then
  echo "# Please provide the input file name as the first argument."
  echo "# Optionally, give 'test' as the second argument to just display result."
  echo "#"
  exit 0
else
  FILE=$1
fi

# The file name should begin with ISO 8601 date
IMPORT_DATE=${FILE:0:10}

# Create the table (=folder in HDFS) if it does not exist
if [ ! -d $DW ]; then
  mkdir -p $DW
fi

CMD='| less -S'

cat $RAW$1 | 

# Remove header
sed -e '1,22d' |

# Recode into UTF-8
recode ISO-8859-1..UTF-8 |

# Convert date 21.12.2014 -> 2014-12-21
perl -pe 's/(\d{2})\.(\d{2})\.(\d{4})/$3-$2-$1/g' |

#
# Timestamp conversions
#

# Fix missing zero': 2013-11-27 7:01 -> 2013-11-27 07:01
perl -pe 's/(\d{4}-\d{2}-\d{2} )(\d{1}:)/$10$2/g' | 

# Add missing seconds: 2004-07-05 09:43 -> 2004-07-05 09:43:00
perl -pe 's/(\d{4}-\d{2}-\d{2} \d{2}:\d{2})\t/$1:00\t/g' | 

# The data contains mixed timestamps and times. Turn all times into 
# timestamps: 2000-04-05 -> 2000-04-05 00:00:00
perl -pe 's/(\d{4}-\d{2}-\d{2})\t/$1 00:00:00\t/g' | 


# Re-order the columns (make the data wider) to make it compatible
# with the newer data export format
permuteCols.R --permutation='c(1:28,30:80,82,84,86,88,90,92,94,98,98,100:125,127,129,131,133,135,137,139,141,143,145,147,149:212,214:246)' |

# Add the import timestamp
perl -pe 's/$/\t'$IMPORT_DATE' 00:00:00/' |

# write to file or to screen is "test" argument is given 
if [ "$2" == "test"  ]
then
  eval " less -S -x"$PREVIEW_TAB_WIDTH
else
  eval " cat > "$DW$FILE
fi
