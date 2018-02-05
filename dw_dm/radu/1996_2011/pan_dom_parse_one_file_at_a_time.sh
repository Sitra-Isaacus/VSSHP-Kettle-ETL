#!/bin/bash

files=/mnt/raw/radu_1996_2011_xml/xml_declaration_fixed/*.xml
regex='.*_([0-9]+)\.xml'
schema="stage_dw"
now=$(date +"%Y-%m-%d")

for  file  in $files; do

if [[ $file =~ $regex ]]; then

io=${BASH_REMATCH[1]}

if [[ $io -gt 523000 ]]; then
	
echo "DOM parsing:"
echo  $file

echo "\n\n\nNyt prosessoidaan tiedostoa: $file\n\n\n" >> pan_log_${now}.txt
/opt/pentaho/pdi-ce-6.0.1.0-386/pan.sh -file:/home/hammaisa/Documents/ETL/radu/1996_2011/dom_parse_radu_old.ktr -param:foldername=$file -param:schema=$schema -level=Error  >> pan_log_${now}.txt

fi
fi
done
