#!/usr/bin/Rscript

#
# Lab data conversion script
#
# Author(s) : Arho Virkki
# Copyright : VTT Technical Reseach Centre of Finland
# Date      : 2016-01-22

args <- commandArgs( trailingOnly = TRUE )

# Environmet variables
#raw_files <- Sys.getenv("ETL_RAW_REPOSITORY")
#table_dir <- Sys.getenv("ETL_TABLE_SCRIPTS")
hive_dw <- Sys.getenv("ETL_HIVE_DW")

if( length(args) != 1 ) {
  cat(paste0("# Please provide the table name as an argument\n",
             "#\n",
             "# Example:\n", 
             "# etl_update_partitions.R lab\n"))

  quit(save="no")

} else {
  table <- args[1]
}

# By convention, partitions should be based on date, which is given 
# in ISO-8601 format (1970-01-02) in the beginning of the file name
#
files <- basename(list.files(paste0(hive_dw, "/", table), recursive=TRUE))
partitions <- substring(files,1,10)


# Create the Hive call for re-constructing  the partitions
hiveCall <- character()

for( partition in partitions ) {
  x <- paste0("ALTER TABLE ", table, " ADD IF NOT EXISTS PARTITION( dt = '",
              partition,"' ) LOCATION '/user/hive/warehouse/ktp/", table,
              "/", partition, "/';")

  hiveCall <- append(hiveCall, x)
}

# Execute the call
cat("Re-creating", table, "partitions...")
system(paste0("beeline -u jdbc:hive2://localhost:10000/ktp -e \"",
              paste(hiveCall, collapse=" "), "\""))
