#!/usr/bin/Rscript
library(data.table)
library(RJDBC)
library(RPostgreSQL)



## Open the PostgreSQL connection
if(!exists("con_oracle")) {
  drv_oracle        <- JDBC("oracle.jdbc.OracleDriver", classPath="/usr/local/lib/java/ojdbc6.jar", " ")
  
con_oracle <- dbConnect(drv_oracle,
                        "jdbc:oracle:thin:@uranus-raportointi.vsshp.net:1521/uraods",
                        "hammaisa", 
                        readLines("/home/ktp/db/uraods.txt")[1])
}



## Open the PostgreSQL connection
if(!exists("con_pg")) {
  drv_pg <- dbDriver("PostgreSQL")
  con_pg <- dbConnect(drv_pg, host="ktppg.vsshp.net", user="ktp",
}




dbSendUpdate(con_oracle, "ALTER SESSION SET current_schema = mdods")


table_size        <- data.table(dbGetQuery(con_pg, "SELECT table_name FROM  INFORMATION_SCHEMA.TABLES where table_schema = 'stage_uraods'"))
tables_ods        <- data.table(dbGetQuery(con_oracle, "SELECT table_name FROM  all_tables"))[grepl("_ODS",TABLE_NAME)]

table_size        <- table_size[paste0(toupper(table_name),"_ODS")%in% tables_ods$TABLE_NAME]

 table_size$ods   <- 0
 table_size$pg    <- 0
print(Sys.time())
 for(this_table_name in as.character(table_size$table_name))
  {
  table_size[table_name == this_table_name]$ods <- unname(dbGetQuery(con_oracle, paste0("select count(*) from ",this_table_name,"_ods")))
  table_size[table_name == this_table_name]$pg  <- unname(dbGetQuery(con_pg,     paste0("select count(*) from stage_uraods.",this_table_name)))
  }
table_size$diff <- table_size$ods - table_size$pg
print(table_size)
