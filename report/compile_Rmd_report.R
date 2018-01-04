#!/usr/bin/env Rscript

## USAGE: compile_Rmd_report.R report.Rmd
# module load pandoc/1.13.1
Rmdfile <- "report.Rmd"
args <- commandArgs(TRUE)
if(! is.na(args[1])) Rmdfile <- as.character(args[1])
rmarkdown::render(Rmdfile)
