#!/bin/bash
schema="stage_radu"
foldername=/mnt/raw/radu_1996_2011_xml/xml_declaration_fixed/
now=$(date +'%Y-%m-%d')
for i in {0..9};
do
# everything but ..... ._..000.xml, which was parsed earlier
regex=".*[^_].[$i]000\.xml"

echo "Now stax parsing files: $regex"
/opt/pentaho/pdi-ce-6.0.1.0-386/kitchen.sh -file:/home/hammaisa/Documents/ETL/radu/1996_2011/stax/stax_parse_radu.kjb -param:foldername=$foldername -param:regex=$regex -param:schema=$schema -level=Error  >  kitchen_parsing_log_${now}_${i}.txt
done
