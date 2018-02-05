#!/bin/sh

# Upload data by partition

# Author(s) : Arho Virkki
# Copyright : VTT Technical Reseach Centre of Finland
# Date      : 2015-12-08


# Buld classpath based on SCRIPTELLA_HOME
_SCRIPTELLA_CP=""
for _arg in $SCRIPTELLA_HOME/lib/*.jar; do
	_SCRIPTELLA_CP=$_SCRIPTELLA_CP:$_arg
done

if [ $# -ne 1 ]
then
  echo "# Please provide the data partition as the first argument. "
  echo "# Example: ./etl_partition.sh 2015-09-29"
  echo "#"
  exit 0
else
  java -Xmx8192m -Dpartition=$1 -classpath \
  $_SCRIPTELLA_CP scriptella.tools.launcher.EtlLauncher etl_partition.xml
fi





