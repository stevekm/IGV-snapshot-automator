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
# uses default paths for regions.bed and igv.jar
docker-test:
	docker run --rm -ti -v $$PWD:/host/ "stevekm/igv-snapshot-automator" bash -c 'make_IGV_snapshots.py /IGV-snapshot-automator/test_data/test_alignments.bam -o /host/snapshots'


# build the Singularity container using Docker
# bind the current directory (project root dir) into the container as /host
# outputs the container file `make_IGV_snapshots.sif` in the current directory
# NOTE: singularityware/singularity:v3.3.0 has `singularity` as the entrypoint
singularity-build:
	docker run --privileged --rm -ti \
	-v $$PWD:/host \
	singularityware/singularity:v3.3.0 \
	build \
	/host/make_IGV_snapshots.sif \
	/host/make_IGV_snapshots.def

# recipe to shell into the singularity container with Docker
singularity-shell:
	docker run --privileged --rm -ti \
	-v $$PWD:/host \
	singularityware/singularity:v3.3.0 \
	shell \
	/host/make_IGV_snapshots.sif

# run the script on the test data inside the Singularity container using Docker
# uses default paths for regions.bed and igv.jar
singularity-test:
	docker run \
	--privileged \
	--rm -ti \
	-v $$PWD:/host \
	singularityware/singularity:v3.3.0 \
	run \
	-B /host:/host \
	/host/make_IGV_snapshots.sif \
	bash -c 'make_IGV_snapshots.py /IGV-snapshot-automator/test_data/test_alignments.bam -o /host/snapshots'
