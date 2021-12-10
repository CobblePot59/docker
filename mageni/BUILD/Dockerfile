FROM debian:buster-slim

ARG token
ARG webpass

RUN apt update && \
    apt -y install supervisor curl lsb-release net-tools && \
    
    curl http://ftp.debian.org/debian/pool/main/l/lsb/lsb-compat_9.20161125_amd64.deb -o /tmp/lsb-compat.deb && \
    apt -y install /tmp/lsb-compat.deb && \
    rm /tmp/lsb-compat.deb

COPY --chmod=0740 BUILD/install /tmp/install

RUN /tmp/install && \
    rm /tmp/install && \

    apt clean && \
    apt autoclean && \

    /usr/local/sbin/mageni-sqlite --user=admin --new-password=$webpass

COPY BUILD/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 443
CMD ["/usr/bin/supervisord"]