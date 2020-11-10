# Docker container with the dependencies needed to run the IGV snapshot automator
# command to build and use container;
# $ docker build -t "stevekm/igv-snapshot-automator" .
# $ docker run --rm -ti -v $PWD:/data/ "stevekm/igv-snapshot-automator" bash
# root@a159c742c957:/# cd /IGV-snapshot-automator/
# root@a159c742c957:/IGV-snapshot-automator# python make_IGV_snapshots.py -bin ../IGV_2.4.10/igv.jar test_data/test_alignments.bam test_data/test_alignments2.bam -o /data/snapshots
FROM ubuntu:16.04

MAINTAINER Stephen M. Kelly

RUN apt-get update && \
apt-get install -y wget \
unzip \
default-jdk \
xvfb \
xorg \
python

RUN wget http://data.broadinstitute.org/igv/projects/downloads/2.4/IGV_2.4.10.zip && \
unzip IGV_2.4.10.zip && \
rm -f unzip IGV_2.4.10.zip

ENV PATH="/IGV_2.4.10/:${PATH}"

# make a dummy batch script in order to load the hg19 genome into the container
# https://software.broadinstitute.org/software/igv/PortCommands
RUN printf 'new\ngenome hg19\nexit\n' > /genome.bat
RUN xvfb-run --auto-servernum --server-num=1 igv.sh -b /genome.bat

ADD . /IGV-snapshot-automator

ENV PATH="/IGV-snapshot-automator/:${PATH}"
