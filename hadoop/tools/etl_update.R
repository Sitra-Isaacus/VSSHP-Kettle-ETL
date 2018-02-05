#!/usr/bin/Rscript

#
# Convert and update changed raw text files
#

# Author(s)     : Arho Virkki
# Copyright     : VTT Technical Reseach Centre of Finland
# Original date : 2015-11-26

#
# Read the environment variables
#
raw_files <- Sys.getenv("ETL_RAW_REPOSITORY")
table_dir <- Sys.getenv("ETL_TABLE_SCRIPTS")
hive_dw <- Sys.getenv("ETL_HIVE_DW")

#
# Check which folders to process
#
tables <- list.files(table_dir)

for( table in tables ) {

  # Which files need to updated? Since hive tables can be partitioned
  # we need recursive listing. The function basename() returns the file name.

  new_files <- setdiff(list.files(paste0(raw_files,"/",table)),
                      basename(list.files(paste0(hive_dw,"/",table), 
                                          recursive=TRUE)))
  
  for( file in new_files ) {
  
    # Call the conversion script
    system(paste0(table_dir, "/", table, "/convert.sh ", file))

    # Check whether we need to update the partitioning by inspectiong the
    # keyword PARTITIONED BY from hive_table.sql
    #
    if( system(paste0("grep -qi 'partitioned by' ", table_dir, "/", table, 
                      "/hive_table.sql")) == 0 ) {
      # Add partition
      system(paste("etl_add_partition.R", table, file))
    }
  }
}
