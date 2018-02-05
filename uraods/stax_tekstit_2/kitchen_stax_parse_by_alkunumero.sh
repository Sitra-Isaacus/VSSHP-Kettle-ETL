#!/bin/bash

for i in {00..99}
do
echo "Processing texts: $i"
/opt/pentaho/pdi-ce-6.0.1.0-386/kitchen.sh -file:/home/hammaisa/Documents/ETL/uraods/stax_tekstit_2/main_stax_tekstit.kjb -level=Error -param:numero=$i
done
