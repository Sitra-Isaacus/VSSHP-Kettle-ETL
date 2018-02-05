#!/usr/bin/Rscript

##
## Permute rows of a tsv file
##

## Author(s)     : Arho Virkki
## Copyright     : VTT Technical Reseach Centre of Finland
## Original date : 2015-11-16


## Global parameters
SEPARATOR = "\t"
EMPTY_ELEMENT = ""


## Parse permutation arguments
##
args <- commandArgs(trailingOnly=TRUE)
pIdx <- which("--permutation=" == substring(args, 1,14))

if( length(pIdx) ) {
    p <- substring(args[pIdx],15)

    ## Create output line template
    max_idx <- eval(parse(text=paste0("max(",p,")")))    
    N <- eval(parse(text=paste0("length(",p,")")))    
    output <- rep("", max_idx)
  
} else {
    ## Show help
    cat(paste0(
        "# Choose and permute text file columns\n",
        "# The permutation parametes uses R languate vector syntax.\n",
        "#\n",
        "# Example: \n",
        "# cat tab_separated_file.txt |./permuteCols.R --permutation='c(5,1)'\n",
        "#\n",
        "# where c(5,1) means that the first column should go as 5th column,\n",
        "# second column shoud go as 2nd, and the rest of the columns are not\n",
        "# used.\n"))
    quit(save="no")
}


## Read the lines from standard input line by line
f <- file("stdin", blocking=TRUE)
open(f)

while(length(line <- readLines(f,n=1)) > 0) {

    ## Split the line based on SEPARATOR
    cols <- strsplit(x=line, split=SEPARATOR)[[1]]

    ## Re-arrange the columns and write the result to standard output
    output[] <- EMPTY_ELEMENT
    eval(parse(text=paste0("output[",p,"] <- cols[1:",N,"]")))
    write(paste0(output,collapse=SEPARATOR), stdout())
}

