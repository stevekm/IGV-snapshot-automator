#### NOTE

I recommed checking out [`igv-reports`](https://github.com/igvteam/igv-reports) which has more features and active development before attempting to use this IGV-snapshot-automator. 

Also check out [BamSnap](https://bamsnap.readthedocs.io/en/latest/) for IGV-like bam file visualization; https://github.com/parklab/bamsnap 

The features of this `IGV-snapshot-automator` are entirely limited to commands that can be used in IGV batch script;

- https://github.com/igvteam/igv/wiki/Batch-commands

- https://software.broadinstitute.org/software/igv/batch

- https://software.broadinstitute.org/software/igv/PortCommands


-----

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

- `-r`: Path to the BED formatted regions file to use (defaults to the included demo `regions.bed`)
- `-nosnap`: Make batchscript without taking snapshots
- `-g`: Genome to use, e.g. `hg19`
- `-ht`: Height of the snapshot, default is 500
- `-o`: Name of the output directory to save the snapshots in (defaults to `IGV_Snapshots`)
- `-bin`: Path to the IGV jar binary to run (defaults to `igv.jar`)
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

Docker and Singularity container files are included. Pre built container images can be found on Dockerhub at https://hub.docker.com/repository/docker/stevekm/igv-snapshot-automator

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

# Notes

Some alternative implementations of the same basic methodology used here for creating IGV snapshots can also be found implemented in Nextflow pipelines;

- https://github.com/stevekm/IGV-snapshot-nf

- https://github.com/NYU-Molecular-Pathology/NGS580-nf/blob/3ba2f970c3fbee56080ba60727f7bf43cb1be3b2/main.nf#L4701-L4876

Running a batch script on IGV:

- https://software.broadinstitute.org/software/igv/batch

- https://software.broadinstitute.org/software/igv/PortCommands

Details on interpretation of IGV visualizations can be found here:

- https://software.broadinstitute.org/software/igv/book/export/html/37

IGV available preferences which could be included in IGV batch scripts:

- https://software.broadinstitute.org/software/igv/prefs.properties

`igv-reports` which makes HTML report outputs with embedded Javascript IGV viewer

- https://github.com/igvteam/igv-reports
