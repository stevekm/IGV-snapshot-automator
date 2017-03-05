# IGV_snapshot_automator
A script to automatically create and run IGV snapshot batchscripts. This script will first write an IGV batch script for the supplied input files, then run IGV headlessly (no GUI shown) and take snapshots at the locations defined in the `regions.bed` file. 

# Usage
Create and run batchscript:
```bash
python make_IGV_snapshots.py /path/to/alignments.bam
```

Make batchscript but don't make snapshots:
```bash
python make_IGV_snapshots.py /path/to/alignments.bam -nosnap
```

See `python make_IGV_snapshots.py --help` for more available options

# Example Output

![chr1_713500_714900_h500](https://cloud.githubusercontent.com/assets/10505524/23584731/4cf127b4-0138-11e7-838c-a947980c8520.png)

# Software Requirements
- Python 2.7 or 3+
- bash version 4.1.2+
- IGV (download script provided in `bin` directory)
- Xvfb
- xdpyinfo
