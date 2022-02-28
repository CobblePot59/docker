FROM postgres:alpine

# Prerequisites
RUN	apk --update add git perl perl-dbi perl-yaml perl-dbd-pg && \

# Configure
	git clone https://gitlab.com/davical-project/davical.git && \
	git clone https://gitlab.com/davical-project/awl.git && \
	rm -rf ./davical/.git/ && \
	rm -rf ./awl/.git/ && \
	mv davical/ /usr/share/ && \
	mv awl/ /usr/share/ && \
# Clean
	apk del git
	
WORKDIR /var/lib/postgresql/data
