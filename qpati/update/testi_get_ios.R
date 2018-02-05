#! /usr/bin/R
library(stringr)
library(data.table)

# get argument value
arguments <- commandArgs(trailingOnly = TRUE)

source_folder <- arguments[1]
temp_file_path <- arguments[2]


this_pattern <- ".*-IO_(\\d+)\\.xml$"



print(arguments)

file.info("QPati-ExportTime_2016-02-01T02.45.03Z-RecordNumber_1178480-SampleNumberInternal_K2016001663-IO_99179673.xml")

this_list_files <- list.files(path= source_folder, pattern = ".*\\.xml")
ttt_1 <- lapply(this_list_files[1:10], file.info)


# this_list_files <- c("jotain_IO_12345.xml","ewew_IO_12345.xml")
result <- data.table(this_list_files)


if(length(this_list_files) != 0){

    
    result[,io := unlist(lapply(str_match_all(this_list_files, this_pattern),"[[",2))]
    
    
}else{print("no")}

write.table(result,
            file = temp_file_path,
            sep = "\t",row.names = F,quote = F,fileEncoding = "UTF8")

# b <- ".*_IO_(\\d+)\\.xml$"


