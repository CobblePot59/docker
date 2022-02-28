FROM alpine

# Prerequisites
RUN	apk --update add git apache2 php php-apache2 php-pgsql php-pdo php-pdo_pgsql php-iconv php-ldap php-xml php-calendar php-curl php-gettext && \

# Configure
	git clone https://gitlab.com/davical-project/davical.git && \
	git clone https://gitlab.com/davical-project/awl.git && \
	rm -rf ./davical/.git/ && \
	rm -rf ./awl/.git/ && \
	mv davical/ /usr/share/ && \
	mv awl/ /usr/share/ && \
	chown -R root:apache /usr/share/davical && \
	find /usr/share/davical/ -type d -exec chmod u=rwx,g=rx,o=rx '{}' \; && \
	find /usr/share/davical/ -type f -exec chmod u=rw,g=r,o=r '{}' \; && \
	chown -R root:www-data /usr/share/awl && \
	find /usr/share/awl -type d -exec chmod u=rwx,g=rx,o=rx '{}' \; && \
	find /usr/share/awl -type f -exec chmod u=rw,g=r,o=r '{}' \; && \
	mkdir /etc/davical && \

# Clean	
	apk del git

WORKDIR /usr/share/davical

EXPOSE 80
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND", "-f", "/etc/apache2/httpd.conf"]