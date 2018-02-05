#!/usr/bin/Rscript

##
## Generate a PostgreSQL table from the Hive equivalent
##

## Author(s)     : Arho Virkki
## Copyright     : VTT Technical Reseach Centre of Finland
## Original date : 2015-11-16

library("DBI")
library("RPostgreSQL")

## Parse command line arguments
##
args <- commandArgs(trailingOnly = TRUE)

if( length(args) != 1 ) {
    cat("#\n# Please provide the data directory (e.g. 'qpati') as",
        "an argument.\n#\n")
    quit(save="no")
}


## Parameters
HIVE_TBL_FILE <- "hive_table.sql"
STAGING_SCHEMA <- "stage"
ETL_PATH <- Sys.getenv("ETL_SCRIPT_PATH")
FOLDER <- args[1]


## Open the DB connection
if( !exists("pg_con")) {
  drv <- dbDriver("PostgreSQL")
  pg_con <- dbConnect(drv, host="ktppg.vsshp.net", user="ktp",
}

## 
## Read and extract the table definition from the HIVE_TBL_FILE
##

hiveTblDef <- paste(readLines(
    paste0(ETL_PATH,FOLDER,"/",HIVE_TBL_FILE)), collapse=" ")

def_start_idx <- gregexpr(pattern="(", text=hiveTblDef, fixed=TRUE)[[1]][1]
def_end_idx <- gregexpr(pattern=")", text=hiveTblDef, fixed=TRUE)[[1]][1]
tableDef <- substring(text=hiveTblDef, def_start_idx, def_end_idx)


##
## Find the table name
##

tmp <- substring(text=hiveTblDef, 1, def_start_idx)

## We assume that legal table name consists of letters [A-Za-z_]
catch <- gregexpr(pattern="[ ]*([A-Za-z_]+)[ ]*[(]", text=tmp, perl=TRUE)[[1]]
len <- attr(catch, "capture.length")

table_name <- substring(tmp, catch+1, catch+len)


##
## Replace Hive keywords with the PostgreSQL equivalents
##
tableDef <- gsub(pattern="STRING", replacement="text",
                 x=tableDef, ignore.case=TRUE)
tableDef <- gsub(pattern="DOUBLE", replacement="double precision",
                 x=tableDef, ignore.case=TRUE)
tableDef <- gsub(pattern="FLOAT", replacement="real",
                 x=tableDef, ignore.case=TRUE)


##
## Drop and re-create the table in PostgreSQL 
##

sqlCall <- paste0(
    "DROP TABLE IF EXISTS ", STAGING_SCHEMA,".", table_name, ";\n",
    "CREATE TABLE ", STAGING_SCHEMA, ".", table_name, "\n",
    gsub(pattern=",", x=tableDef, replacement=",\n "), ";\n")

cat("# Truncating table:", table_name, "\n")
res <- dbSendQuery(pg_con, sqlCall)


##
## Generate the SELECT and INSERT statements
##

## Create a directory for the artefacts, if it does not exist
system(paste0("mkdir -p ",ETL_PATH, FOLDER,"/build/"))


cat("# Generating Scriptella components:\n")
cat(paste0("# ", ETL_PATH, FOLDER,"/build/{select.sql,insert.sql}\n"))

sink(paste0(ETL_PATH, FOLDER,"/build/select.sql"))
cat("SELECT * FROM", table_name, "\n")
sink()


fieldNames <- dbListFields(pg_con, table_name)
N <- length(fieldNames)

sink(paste0(ETL_PATH, FOLDER,"/build/insert.sql"))
cat(paste0("INSERT INTO ", STAGING_SCHEMA,".", table_name, " (",
           paste(fieldNames, collapse=", "),") \n",
           "VALUES (", paste0("?", 1:N, collapse=", "), ");\n"))
sink()

cat("#\n")
