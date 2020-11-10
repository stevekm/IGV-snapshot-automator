# download and install IGV
install: igv.jar

igv.jar: IGV_2.4.10.zip
	unzip IGV_2.4.10.zip && \
	ln -s IGV_2.4.10/igv.jar

IGV_2.4.10.zip:
	wget http://data.broadinstitute.org/igv/projects/downloads/2.4/IGV_2.4.10.zip -O tmp && mv tmp IGV_2.4.10.zip

.INTERMEDIATE: tmp


# build the Docker container
docker-build:
	docker build -t "stevekm/igv-snapshot-automator" .

# run the script on the test data inside the docker container
docker-test:
	docker run --rm -ti -v $PWD:/data/ "stevekm/igv-snapshot-automator" bash -c 'make_IGV_snapshots.py /IGV-snapshot-automator/test_data/test_alignments.bam -o /data/snapshots -r /IGV-snapshot-automator/regions.bed -bin /IGV-snapshot-automator/igv.jar'


# build the Singularity container using Docker
singularity-build:
	docker run --privileged --rm -ti \
	-v $$PWD:$$PWD \
	singularityware/singularity:v3.3.0 \
	build \
	$$PWD/make_IGV_snapshots.sif \
	$$PWD/make_IGV_snapshots.def
