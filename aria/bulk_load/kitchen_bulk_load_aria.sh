#!/bin/bash

directory=/mnt/raw/aria/bom_removed/
schema="stage_aria"

echo
echo "loading data from aria files in..."
echo $directory
echo "... into schema ..."
echo $schema
echo "..."

/opt/pentaho/pdi-ce-6.0.1.0-386/kitchen.sh -file:/home/hammaisa/Documents/ETL/aria/bulk_load/bulk_insert_tables.kjb -param:foldername=$directory -param:schema=$schema -level=Basic

