#! /usr/bin/env Rscript

library(data.table)


arguments <- commandArgs(trailingOnly = TRUE)

temp_input_file_path <- arguments[1]
temp_output_file_path <- arguments[2]

#temp_input_file_path <- "/home/hammaisa/ETL/main/transformations/patologia/temp_qpatitable_script_infile.txt"
#temp_input_file_path <- "/home/stepanom/ETL/main/transformations/patologia/temp_qpatitable_script_infile.txt"
#temp_output_file_path <-  "/home/hammaisa/ETL/main/transformations/patologia/temp_qpatitable_script_outfile.txt"



split_to_data_table <- function(BBB,splitting_char = "|",fixed = TRUE){
  A1 <- data.table(BBB)
  dt2 <- NULL
  for(xx in names(A1)){ 
    yy = setDT(tstrsplit(A1[[xx]], splitting_char, fixed = fixed))[]
    
    if(length(yy) != 1) setnames(yy,paste0(xx,"_",formatC(1:length(yy),
                                                          width = nchar(max(length(yy))), 
                                                          format = "d", 
                                                          flag = "0"))) else setnames(yy,xx)
    if(is.null(dt2) == TRUE) dt2 <- yy else dt2 <-  cbind(dt2,yy)
  }
  
  return(dt2)
  
  
  
}

###############


con_table <- function(BBB = "", 
                      with_given_times = FALSE, 
                      all_value = FALSE,
                      with_zeros = FALSE, 
                      separator_in_output = FALSE, 
                      asIntegers = FALSE, 
                      asNumerics = FALSE, 
                      try_to_split ="",
                      empty_char = "")
{
  
  #     BBB <- data.table(henkilo = paste0("Henkilo_", sample(1:10,100,replace = TRUE)),
  #                       laake   = paste0("laake_", sample(1:3,100,replace = TRUE)),
  #                       what    = LETTERS[sample(1:20,100,replace = TRUE)],
  #                       when    =  sample(1:1000,100,replace = TRUE))
  #   
  if(length(BBB)<3) warning("cannot create con table") else{
    BBB            <- data.table(BBB)
    A1             <- copy(BBB)
    names_to_split <- names(A1[,c(1:(length(A1) - 2)), with = FALSE])
    what_name      <- names(A1[,c(length(A1) - 1),     with = FALSE])
    value_name     <- names(A1[,c(length(A1)),         with = FALSE])
    
    for(this_name in names_to_split)  A1[[this_name]] <- as.character(A1[[this_name]])
    
    
    # A2 <- A1[,c(1:(length(A1)-2)),with = FALSE][,lapply(.SD,function(xxx) gsub("\\|","",xxx))]
    A1$rowname     <- 1:nrow(A1)
    A1$id          <- A1[,list(id = paste0(.SD,collapse = "-|-")), by = rowname,.SDcols = names_to_split]$id
    A1$what        <- gsub("^_+|_+$","",gsub("_+","_",gsub(" +|\\.+","_",as.character(A1[[what_name]]))))
    A1$value       <- as.character(A1[[value_name]])
    
    A1 <- A1[,list(id,what,value)]
    
    
    
    # if in what we have number, then table() function will add 'X' before them, to avoid this we add 'QQQQQ'
    # and then take it out
    
    A1[grepl("^[0-9]",what)]$what <- paste0("QQQQQQ",A1[grepl("^[0-9]",what)]$what)
    
    # 
    #
    A1[is.na(id)]$id       <- "NA"
    A1[is.na(what)]$what   <- "NA"
    A1[is.na(value)]$value <- "NA"
    
    if(with_given_times == TRUE){A1  <- A1[,list(value = { y = table(value); 
    paste0(paste0(names(y), " (",unclass(y),")"),collapse = ", ")}), 
    by = list(what,id)] 
    } else {
      A1  <- A1[,list(value = if(all_value == TRUE) paste0(sort(unique(value)), collapse = ",") else value[1]), 
                by = list(what,id)]
    }
    
    A1 <- A1[base:::order(what,id)]
    B1 <- data.frame(unclass(table(A1[,list(id,what)], useNA = "ifany")))
    
    A1[value == 0]$value <- "00000000000000000"
    
    B1[B1 != 0] <- A1$value
    
    if(with_zeros == FALSE)   B1[B1 == 0]  <- as.character(empty_char)
    
    B1[B1 == "00000000000000000"] <- 0
    
    B1 <- data.table(values = rownames(B1),B1)
    B1 <- data.table(B1)
    
    if(separator_in_output == FALSE) {B1 <- data.table(split_to_data_table(B1$values,"-|-"),
                                                       B1[,2:length(B1),with = FALSE])
    setnames(B1,1:length(names_to_split),names_to_split)
    if(try_to_split != ""){
      B1 <- cbind(split_to_data_table(B1[,names_to_split,with = FALSE],try_to_split),
                  B1[,(length(names_to_split)+1):length(B1),with = FALSE])
    }
    } else setnames(B1,1,paste0(names_to_split,collapse = "_"))
    
    setnames(B1,gsub("QQQQQQ","",names(B1)))
    
    if(asIntegers == TRUE & asNumerics == FALSE) B1 <- B1[,lapply(.SD, function(xxx) if(all(grepl("^\\d*$",xxx)|xxx %in% c("NA","")|is.na(xxx)) == TRUE) as.integer(xxx) else xxx)]
    if(asNumerics == TRUE) B1 <- B1[,lapply(.SD, function(xxx) if(all(grepl("^-?\\d*\\.?\\d*$",xxx)|xxx %in% c("NA","")|is.na(xxx)) == TRUE) as.numeric(xxx) else xxx)]
    
    
    return(B1)}
}

####################
modif <-  function(sss1,as.expand = FALSE) {
  qpatianswer_id = sss1$qpatianswer_id[1];
  tablenumber = sss1$tablenumber[1];
  
  # sss1$qpatianswer_id <- NULL;
  # cat(qpatianswer_id,"\n");
  tablename <- as.character(sss1$tablename[1]);
  # sss1$tablename <- NULL;
  
  this_col_names <- names(sss1)[grepl("col_",names(sss1))]
  sss1a <- sss1[,this_col_names,with = FALSE];
  
  columns = !apply(sss1a,2,function(x) all(x == "")); 
  columns[2] <- TRUE
  
  sss1a = sss1a[,columns, with = FALSE];
  
  
  if(nrow(sss1a) > 1 & (length(names(sss1a))>2 | as.expand))
  {
    sss1a = data.table(qpatianswer_id,
                       tablenumber,
                       tablename,
                       expand.grid(sss1a[[1]][-c(1)],unlist(sss1a[1])[-c(1)],stringsAsFactors = FALSE),
                       unlist(sss1a[-c(1),-c(1),with = FALSE]));
    setnames(sss1a,c("qpatianswer_id","tablenumber","tablename","mittaus","elin","tulos"));
  } else {
    if( (nrow(sss1a) > 1 | "col_0" %in% names(sss1a)) & length(names(sss1a)) == 2){sss1a = data.table(qpatianswer_id = qpatianswer_id,
                                                                                                      tablenumber = tablenumber,
                                                                                                      tablename = tablename,
                                                                                                      mittaus = "",
                                                                                                      elin = sss1a$col_0,
                                                                                                      tulos = sss1a$col_1)}
    else {sss1a = data.table(NULL)}
    
  };
  
  return(sss1a)
}
############

qPati_taulukko <- function (sas,as.expand = FALSE) {
  
  sas$what <- cumsum(sas$col_0 == ""  | !duplicated(sas[,list(qpatianswer_id, tablenumber, tablename)]))
  
  
  
  sas <- sas[,modif(.SD,as.expand),by = what]
  sas$what <- NULL
  
  return(sas)
  
}


###########################


if ( ! is.na(file.info(temp_input_file_path)$size)  &&  file.info(temp_input_file_path)$size != 0) 
{

try({
  this_qpati_table <- fread(temp_input_file_path)

print("read file")



list_of_known_tablenames <- c("SYDNEY-LUOKITUS SUPPEA.tbl",
                              "SYDNEY-LUOKITUS.tbl",
                              "MUNUAINEN IMMUNOFLORESENSSI.tbl",
                              "ENNUSTETEKIJÄT.tbl",
                              "RINTASYÖVÄN ENNUSTETEKIJÄT.tbl",
                              "IHO IMMUNOFLUORESENSSI.tbl",
                              "ZAvaus.tbl",
                              "SOLULASKENTA BAL.tbl",
                              "VIRTAUSSYTOMETRIA.tbl",
                              "BETHESDA 2001.tbl",
                              "U-GLYKOSAMINOGLYKAANIT.tbl",
                              "S-KARNITIINI.tbl",
                              "G-RT-ASO.3.tbl",
                              "G-GEN-ASO.3.tbl", # 14
                              "KLL jäännös.tbl",
                              "luuydin dg.tbl",
                              "luuydin ja Plasmasolueristys dg.tbl",
                              "Istukkanäyte.tbl",
                              "G-RT-ASO.tbl",
                              "G-RT-ASO.2.tbl",
                              "GASO-PCR.tbl",
                              "Telo-FISH.tbl",
                              "ALL jäännös.tbl",
                              "G-GEN-ASO.2.tbl",## treat this the same way as the "G-GEN-ASO.3.tbl"
				"U-KARNITIINI.tbl") ## treat this the same way as the "S-KARNITIINI.tbl"

this_qpati_table_1 <- this_qpati_table[as.character(tablename) %in% list_of_known_tablenames]
if(nrow(this_qpati_table_1) == 0 ) {print("error, new table name!")
}else{

this_qpati_table_1 <- con_table(this_qpati_table_1[,list(qpatianswer_id, tablenumber,  tablename,row,col,value)])


this_qpati_table_1 <- this_qpati_table_1[order(qpatianswer_id,as.integer(tablenumber),as.integer(row))]

setnames(this_qpati_table_1, gsub("(\\d+)","col_\\1", names(this_qpati_table_1)))


this_qpati_table_1[,row := as.integer(row)]


setkey(this_qpati_table_1,qpatianswer_id,tablenumber,tablename,row)

  
  # this_qpati_table_1[tablename == "SYDNEY-LUOKITUS SUPPEA.tbl"]
  # this_qpati_table_1[tablename == "SYDNEY-LUOKITUS.tbl"]
  # this_qpati_table_1[tablename == "MUNUAINEN IMMUNOFLORESENSSI.tbl"]
  # this_qpati_table_1[tablename == "ENNUSTETEKIJÄT.tbl"]
  # this_qpati_table_1[tablename == "RINTASYÖVÄN ENNUSTETEKIJÄT.tbl"]
  # this_qpati_table_1[tablename == "IHO IMMUNOFLUORESENSSI.tbl"]
  # 
  # this_qpati_table_1[tablename == "ZAvaus.tbl"][,list(c(col_0,col_2),c(col_1,col_3)),list(qpatianswer_id, tablenumber,  tablename, row)]
  # 
  # 
  # this_qpati_table_1[tablename == "SOLULASKENTA BAL.tbl"]
  # this_qpati_table_1[tablename == "VIRTAUSSYTOMETRIA.tbl"]
  # this_qpati_table_1[tablename == "BETHESDA 2001.tbl"]
  # 
  # 
  
  
  # select only: SYDNEY-LUOKITUS SUPPEA.tbl, SYDNEY-LUOKITUS.tbl, MUNUAINEN IMMUNOFLORESENSSI.tbl
  this_qpati_table_a <- merge(this_qpati_table_1,
                                             data.table( tablename = list_of_known_tablenames[1:3]),
                                             by = "tablename")
  
  this_qpati_table_a <- qPati_taulukko(this_qpati_table_a) 
  

  if(nrow(this_qpati_table_a) != 0){    
    this_qpati_table_a[elin == "tulehdus"]$elin <- "Krooninen tulehdus"
    this_qpati_table_a[elin == "atrofia"]$elin <- "Villus- atrofia"
    this_qpati_table_a[elin == "teetti"]$elin <- "Aktiviteetti"
    this_qpati_table_a[elin == "metapl." & mittaus %in% c("Antrum","Corpus")]$elin <- "Intestin. metapl."
    this_qpati_table_a[elin == "metapl." & mittaus %in% c("Ruokatorvi")]$elin <- "Intest. metapl."
    this_qpati_table_a[elin == "metapl." & mittaus %in% c("Duodenum")]$elin <- "Gastr. metapl."
    this_qpati_table_a[elin == "bakt."]$elin <- "Helico- bakt."
    this_qpati_table_a[elin == "plasia"]$elin <- "Dys- plasia"
    
    
    this_qpati_table_a <- this_qpati_table_a[,list(qpatianswer_id,tablenumber,tablename,variable = paste0(mittaus,": ",elin),value = tulos)]
  } else this_qpati_table_a  <- data.table(qpatianswer_id = NA,tablenumber = NA,tablename = NA,variable = NA,value = NA)[0]
  
  
  this_qpati_table_b <- this_qpati_table_1[as.character(tablename) %in% list_of_known_tablenames[4:6]]
  
  if(nrow(this_qpati_table_b) != 0){ 
    this_qpati_table_b$col_0 <- paste0(this_qpati_table_b$col_0,"(",this_qpati_table_b$col_2,")")
    
    this_qpati_table_b[col_0 == "()"]$col_0 <- ""
    this_qpati_table_b$col_2 <- ""
    
    this_qpati_table_b <- qPati_taulukko(this_qpati_table_b,as.expand = TRUE)
    
    
    this_qpati_table_b <- this_qpati_table_b[,list(qpatianswer_id,tablenumber,tablename,variable = paste0(mittaus," (",elin,")"),value = tulos)]
  }else this_qpati_table_b  <- data.table(qpatianswer_id = NA,tablenumber= NA,tablename = NA,variable = NA,value = NA)[0]
  
  
  this_qpati_table_c <- this_qpati_table_1[as.character(tablename) %in% list_of_known_tablenames[8:9]]
  if(nrow(this_qpati_table_c) != 0){ 
    this_qpati_table_c <- this_qpati_table_c[,list(qpatianswer_id,tablenumber,tablename,variable = paste0(col_0," (",col_2,")"),value = col_1)]
  }else this_qpati_table_c  <- data.table(qpatianswer_id = NA,tablenumber = NA,tablename = NA,variable = NA,value = NA)[0]
  
  this_qpati_table_d <- this_qpati_table_1[as.character(tablename) %in% list_of_known_tablenames[10]]
  if(nrow(this_qpati_table_d) != 0){ 
    this_qpati_table_d <- this_qpati_table_d[,list(qpatianswer_id,tablenumber,tablename,variable = col_0,value = col_1)]
  }else this_qpati_table_d  <- data.table(qpatianswer_id = NA,tablenumber = NA,tablename = NA,variable = NA,value = NA)[0]
  
  
  this_qpati_table_e <- this_qpati_table_1[as.character(tablename) %in% list_of_known_tablenames[7]]
  if(nrow(this_qpati_table_e) != 0){ 
    this_qpati_table_e <- this_qpati_table_e[,list(variable=c(col_0,col_2),value = c(col_1,col_3)),list(qpatianswer_id,tablenumber,tablename)]
  }else this_qpati_table_e  <- data.table(qpatianswer_id = NA,tablenumber = NA,tablename = NA,variable = NA,value = NA)[0]
  
  
  
  
  
  this_qpati_table_f <- this_qpati_table_1[as.character(tablename) %in% list_of_known_tablenames[11]]
  if(nrow(this_qpati_table_f) != 0){ 
    
    this_qpati_table_f[col_2 == ""]$col_2 <- paste0("Viitealue: ", this_qpati_table_f[col_2 == ""]$col_4)
    this_qpati_table_f$col_0 <- paste0(this_qpati_table_f$col_0," (",this_qpati_table_f$col_2,")")
    this_qpati_table_f <- this_qpati_table_f[,list(qpatianswer_id,tablenumber,tablename,variable = col_0,value = col_1)]
  }else this_qpati_table_f  <- data.table(qpatianswer_id = NA,tablenumber= NA,tablename = NA,variable = NA,value = NA)[0]
  
  
  
  this_qpati_table_g <- this_qpati_table_1[as.character(tablename) %in% c(list_of_known_tablenames[12], list_of_known_tablenames[25])]
  if(nrow(this_qpati_table_g) != 0){ 
    
    this_qpati_table_g$col_0 <- paste0(this_qpati_table_g$col_0," (",this_qpati_table_g$col_2,")", " Viitealue: ", this_qpati_table_g$col_4)
    this_qpati_table_g <- this_qpati_table_g[,list(qpatianswer_id,tablenumber,tablename,variable = col_0,value = col_1)]
  }else this_qpati_table_g  <- data.table(qpatianswer_id = NA,tablenumber= NA,tablename = NA,variable = NA,value = NA)[0]
  
  
  this_qpati_table_i <- this_qpati_table_1[as.character(tablename) %in% list_of_known_tablenames[13]]
  if(nrow(this_qpati_table_i) != 0){ 
    
      this_qpati_table_i <- rbind(    this_qpati_table_i[col_1 != ""][,list(variable = paste0(col_0,"_",1),value = col_1),list(qpatianswer_id, tablenumber,       tablename)],
                                      this_qpati_table_i[col_2 != ""][,list(variable = paste0(col_0,"_",2),value = col_2),list(qpatianswer_id, tablenumber,       tablename)],
                                      this_qpati_table_i[col_3 != ""][,list(variable = paste0(col_0,"_",3),value = col_3),list(qpatianswer_id, tablenumber,       tablename)],
                                      this_qpati_table_i[col_4 != ""][,list(variable = paste0(col_0,"_",4),value = col_4),list(qpatianswer_id, tablenumber,       tablename)]
                                      
      )
        
  }else this_qpati_table_i  <- data.table(qpatianswer_id = NA,tablenumber= NA,tablename = NA,variable = NA,value = NA)[0]
  
  
  
  this_qpati_table_k <- this_qpati_table_1[as.character(tablename) %in% list_of_known_tablenames[14]]
  if(nrow(this_qpati_table_k) != 0){ 
    this_qpati_table_k <- rbind(    this_qpati_table_k[col_1 != ""][,list(variable = paste0(col_0,"_",1),value = col_1),list(qpatianswer_id, tablenumber,       tablename)],
                                    this_qpati_table_k[col_2 != ""][,list(variable = paste0(col_0,"_",2),value = col_2),list(qpatianswer_id, tablenumber,       tablename)],
                                    this_qpati_table_k[col_3 != ""][,list(variable = paste0(col_0,"_",3),value = col_3),list(qpatianswer_id, tablenumber,       tablename)]
    )
    
  }else this_qpati_table_k  <- data.table(qpatianswer_id = NA,tablenumber= NA,tablename = NA,variable = NA,value = NA)[0]
  
  this_qpati_table_l <- this_qpati_table_1[as.character(tablename) %in% list_of_known_tablenames[15]]
  if(nrow(this_qpati_table_l) != 0){ 
    this_qpati_table_l$col_0 <- paste0("putki_",this_qpati_table_l$col_0)
    this_qpati_table_l[col_0 == "putki_Putki"]$col_0 <- ""
    this_qpati_table_l <- qPati_taulukko(this_qpati_table_l) 
    this_qpati_table_l <- this_qpati_table_l[,list(qpatianswer_id,tablenumber,tablename,variable = paste0(mittaus,": ",elin),value = tulos)]
    this_qpati_table_l <- this_qpati_table_l[value != ""]
   
  }else this_qpati_table_l  <- data.table(qpatianswer_id = NA,tablenumber= NA,tablename = NA,variable = NA,value = NA)[0]
  
  this_qpati_table_m <- this_qpati_table_1[as.character(tablename) %in% list_of_known_tablenames[23]]
  if(nrow(this_qpati_table_m) != 0){ 
    this_qpati_table_m$col_0 <- paste0("putki_",this_qpati_table_m$col_0)
    this_qpati_table_m[col_0 == "putki_Putki"]$col_0 <- ""
    this_qpati_table_m <- qPati_taulukko(this_qpati_table_m) 
    this_qpati_table_m <- this_qpati_table_m[,list(qpatianswer_id,tablenumber,tablename,variable = paste0(mittaus,": ",elin),value = tulos)]
    this_qpati_table_m <- this_qpati_table_m[value != ""]
    
  }else this_qpati_table_m  <- data.table(qpatianswer_id = NA,tablenumber= NA,tablename = NA,variable = NA,value = NA)[0]
  
    this_qpati_table_n <- this_qpati_table_1[as.character(tablename) %in% list_of_known_tablenames[24]]
    if(nrow(this_qpati_table_n) != 0){ 
      this_qpati_table_n[as.character(col_0) == "Näytteenottopvm"]$col_0 <- ""
      this_qpati_table_n <- qPati_taulukko(this_qpati_table_n) 
      
      this_qpati_table_n <- this_qpati_table_n[elin != "" & tulos != ""]
      this_qpati_table_n <- this_qpati_table_n[,list(qpatianswer_id,tablenumber,tablename,variable = paste0(mittaus,": ",elin),value = tulos)]

    }else this_qpati_table_n  <- data.table(qpatianswer_id = NA,tablenumber= NA,tablename = NA,variable = NA,value = NA)[0]
    

    print("not transfereted")
    print(this_qpati_table_1[as.character(tablename) %in% list_of_known_tablenames[16:22]][,length(unique(qpatianswer_id)),tablename])
    
    
  this_qpati_table_all <- rbind(this_qpati_table_a,
                                this_qpati_table_b,
                                this_qpati_table_c,
                                this_qpati_table_d,
                                this_qpati_table_e,
                                this_qpati_table_f,
                                this_qpati_table_g,
                                this_qpati_table_i,
                                this_qpati_table_k,
                                this_qpati_table_l,
                                this_qpati_table_m,
                                this_qpati_table_n)
  
  this_qpati_table_all$variable <- gsub("'"," ",this_qpati_table_all$variable)
  this_qpati_table_all$value    <- gsub("'"," ",this_qpati_table_all$value)
  
  
  print("insert to table")
  
  write.table(this_qpati_table_all, file = temp_output_file_path,quote=FALSE, sep = "\t", row.names=FALSE, fileEncoding = "utf8")
  
  
}

}, silent = FALSE)
} # end if
