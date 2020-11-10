# download and install IGV

install: igv.jar

igv.jar: IGV_2.4.10.zip
	unzip IGV_2.4.10.zip && \
	ln -s IGV_2.4.10/igv.jar

IGV_2.4.10.zip:
	wget http://data.broadinstitute.org/igv/projects/downloads/2.4/IGV_2.4.10.zip -O tmp && mv tmp IGV_2.4.10.zip

.INTERMEDIATE: tmp
