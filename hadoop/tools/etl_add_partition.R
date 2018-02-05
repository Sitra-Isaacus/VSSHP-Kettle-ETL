#!/usr/bin/Rscript

##
## Lab data conversion script
##
## Author(s) : Arho Virkki
## Copyright : VTT Technical Reseach Centre of Finland
## Date      : 2015-12-02

args <- commandArgs( trailingOnly = TRUE )

if( length(args) != 2 ) {
    cat(paste0("#\n",
        "# Add partition to given table based on file name (in case that\n",
        "# the partition does not already exist).\n",
        "#\n",
        "# Example: add_partition.R lab 2015-11-10_labdw_data2015-11.txt\n",
        "#\n"))
    quit(save="no")
}

tableName <- args[1]
fileName <- args[2]
partition <- substr(fileName,1,10)

hiveCall <- paste0(
    "beeline -u jdbc:hive2://localhost:10000/ktp -e \"",
    "ALTER TABLE ", tableName, " ADD IF NOT EXISTS PARTITION( dt = '",
    partition,"' ) LOCATION '/user/hive/warehouse/ktp/", tableName,
    "/", partition, "/';\"")

system(hiveCall)
