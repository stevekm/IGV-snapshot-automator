# IGV Snapshot Automator
A script to automatically create and run [IGV snapshot batchscripts](http://software.broadinstitute.org/software/igv/batch). This script will first write an IGV batch script for the supplied input files, then load all supplied files for visualization (.bam, etc) in a headless IGV session and take snapshots at the locations defined in the `regions.bed` file.

Designed for use on Linux systems, and intended to be used as a component of sequencing analysis pipelines.

# Usage

## Download IGV

Use the included Makefile recipe to download a copy of IGV

```
make install
```

## Run Snapshotter

- Put your chromosome regions to visualize in the `regions.bed` file (provided), or another BED format file

- Locate your files to visualize (e.g. .bam & .bam.bai files)

- Create and run batchscript. Example command:
```bash
$ python make_IGV_snapshots.py /path/to/alignments1.bam /path/to/alignments2.bam
```

## Demo

To run the script on the included demo files:

```bash
$ python make_IGV_snapshots.py test_data/test_alignments.bam test_data/test_alignments2.bam
```

# Options

See `python make_IGV_snapshots.py --help` for available options. Here are a few:

- `-r`: Path to the BED formatted regions file to use:
```bash
$ python make_IGV_snapshots.py /path/to/alignments1.bam /path/to/alignments2.bam -r /path/to/my_peaks.bed
```

- `-nosnap`: Make batchscript without taking snapshots:
```bash
$ python make_IGV_snapshots.py /path/to/alignments1.bam /path/to/alignments2.bam -nosnap
```
- `-g`: Genome to use, e.g. `hg19`
- `-ht`: Height of the snapshot, default is 500
- `-o`: Name of the output directory to save the snapshots in.
- `-bin`: Path to the IGV jar binary to run
- `-mem`: Memory to allocate to IGV (MB)
- `-suffix`: Filename suffix to place before '.png' in the snapshots
- `-onlysnap`: Skip batchscript creation and only run IGV using the supplied batchscript file
- `-nf4`: "Name field 4" mode, uses values saved in 4th field of the `regions.bed` file as the output filename of the PNG snapshot. Use this when you have pre-made filenames you wish to use for each snapshot.
- `-s` or `-group_by_strand`: Group alignment(s) by read strand with forward on top and reverse on the bottom.



# Example Output

![chr1_713500_714900_h500](https://cloud.githubusercontent.com/assets/10505524/23584731/4cf127b4-0138-11e7-838c-a947980c8520.png)

# Notes

Default memory allotment is set at 4GB; this can be changed with the `-mem` argument (e.g. `-mem 1000` sets memory to 1GB).

IGV may take several minutes to run, depending on the number of input files and regions to snapshot. Stdout messages from the program may not appear immediately in the console.

# Containers

Docker and Singularity container files are included.

## Docker

The Docker container can be built with the included Makefile recipe

```
make docker-build
```

The test data can be run with

```
make docker-test
```

## Singularity

The Singularity container can be built using Docker with the included Makefile recipe

```
make singularity-build
```

The test data can be run with

```
make singularity-test
```

# Software Requirements
- Python 2.7 or 3+
- bash version 4.1.2+
- IGV (download script provided in `bin` directory)
- Xvfb
- xdpyinfo
- Java runtime environment
- Docker or Singularity for building and running containers
