#! /bin/bash

files=/mnt/raw/radu_1996_2011_xml/originals/*.xml
newdir=/mnt/raw/radu_1996_2011_xml/xml_declaration_fixed

old="<?xml version='1.0' encoding='UTF-8' ?>"
new=""

for file in $files;
do
newname=$(basename $file)
newfile="${newdir}/${newname}"
# write xml declaration in the beginning of the file once
echo "$old" > $newfile
# remove other instances of xml declaration from file
sed "s/$old/$new/g" $file >> $newfile

done
