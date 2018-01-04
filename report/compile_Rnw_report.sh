#!/bin/bash

# compiles a .Rnw file to a .pdf
# USAGE: compile_Rnw_report.sh report.Rnw

Rnw_file="${1:-report.Rnw}"

compile_Rnw () {
    # compile .Rnw to .tex
    local Rnw_file="$1"
    
    if [ -f "$Rnw_file" ]; then
        Rscript --slave --no-save --no-restore - "${Rnw_file}" <<EOF
## R code
args <- commandArgs(TRUE)
library("knitr")
knit(args[1])
EOF
    fi
}

compile_tex () {
    # compile .tex to .pdf
    local tex_file="$1"
    
    if [ -f "$tex_file" ]; then
        pdflatex "${tex_file}" && pdflatex "${tex_file}"
    fi
}

compile_Rnw "$Rnw_file" 

tex_file="${Rnw_file%%.Rnw}.tex"

compile_tex "$tex_file"