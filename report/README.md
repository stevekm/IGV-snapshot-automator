# IGV Snapshot Report

This directory contains report templates to use with the IGV Snapshot output. By default, the reports will look for `.png` files in the directory `../IGV_Snapshots/`, and include each file found in a report output. 

If your IGV snapshot directory has a different name or path, you can either adjust the path inside the report template, or make a symlink with that name at that location. 

## PDF Output

A PDF report can be generated using the included `report.Rnw`. Compile it with the command:

```bash
./compile_Rnw_report.sh
```


This report requires LaTeX to be installed with the `standalone` package. If you are using Linux, or a Linux-style system, and you already have LaTeX installed, you can install this package with the included `Makefile` with the command:

```bash
make
```

## HTML Output

An HTML formatted report can be generated with the included `report.Rmd` file. Compile it with the included script:

```bash
# module load pandoc/1.13.1
./compile_Rmd_report.R
```

# Software

Software used in report creation

- R programming langauge

  - `Hmisc`, `knitr` packages

- LaTeX
  
  - `standalone` package

- pandoc 1.13.1+