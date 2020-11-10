# Docker container with the dependencies needed to run the IGV snapshot automator

# commands to build and use container;
# $ docker build -t "stevekm/igv-snapshot-automator" .
# $ docker run --rm -ti -v $PWD:/data/ "stevekm/igv-snapshot-automator" bash -c 'make_IGV_snapshots.py /IGV-snapshot-automator/test_data/test_alignments.bam -o /data/snapshots -r /IGV-snapshot-automator/regions.bed -bin /IGV-snapshot-automator/igv.jar'
FROM ubuntu:16.04

MAINTAINER Stephen M. Kelly

RUN apt-get update && \
apt-get install -y wget \
unzip \
default-jdk \
xvfb \
xorg \
python \
make

# add the source code for the repo to the container
ADD . /IGV-snapshot-automator
ENV PATH="/IGV-snapshot-automator/:/IGV-snapshot-automator/IGV_2.4.10/:${PATH}"

# install IGV via the Makefile
RUN cd /IGV-snapshot-automator && make install

# make a dummy batch script in order to load the hg19 genome into the container
# https://software.broadinstitute.org/software/igv/PortCommands
RUN printf 'new\ngenome hg19\nexit\n' > /genome.bat
RUN xvfb-run --auto-servernum --server-num=1 igv.sh -b /genome.bat
