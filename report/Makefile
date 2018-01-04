# install the 'standalone' LaTeX document class

install: standalone 

standalone: download-standalone extract-standalone

download-standalone: 
	wget http://mirrors.ctan.org/install/macros/latex/contrib/standalone.tds.zip
	
extract-standalone: 
	unzip standalone.tds.zip -d ~/texmf/

clean:
	rm -f standalone.tds.zip

.INTERMEDIATE: standalone.tds.zip 