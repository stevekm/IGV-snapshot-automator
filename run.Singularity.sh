#!/bin/bash

# example wrapper script to launch the snapshot script inside a Singularity container (needed if xvfb is not installed)

# default path to Singularity container file
container="${1:-IGV.simg}"

# need to load Singularity if running on Big Purple HPC
if [ "$(hostname  | grep -q 'bigpurple' ; echo $?)" -eq 0 ]; then
    module load singularity/2.5.2

    # command to launch Singularity container and run commands inside the container
    # NOTE: you may need to make sure that the directory filesystem root and the current dir are bound to the container with `-B`
    singularity exec \
    -B /gpfs \
    -B "${PWD}" \
    "${container}" \
    /bin/bash -c " \
    cd ${PWD}
    python make_IGV_snapshots.py test_data/test_alignments.bam test_data/test_alignments2.bam
    "
fi
