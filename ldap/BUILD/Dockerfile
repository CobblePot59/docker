FROM debian:stable-slim

EXPOSE 53 53/udp 88 88/udp 135 139 389 389/udp 445 464 464/udp 636 3268 3269

ARG SAMBA_VERSION

# Prerequisites
RUN DEP_PKG="python3 python3-dev python3-cryptography python3-pyasn1 \
             python3-dateutil python3-markdown python3-dnspython\
             wget gcc make pkg-config flex bison libpopt-dev \
             libgnutls28-dev libgpgme-dev libparse-yapp-perl \
             libjansson-dev libfam-dev libarchive-dev liblmdb-dev \
             libacl1-dev libldap2-dev libpam-dev libdbus-1-dev" && \
    apt update && \
    apt install -y $DEP_PKG

# Install
RUN wget https://download.samba.org/pub/samba/stable/samba-$SAMBA_VERSION.tar.gz && \
    tar xzvf samba-$SAMBA_VERSION.tar.gz && \
    cd samba-$SAMBA_VERSION && \
    ./configure --prefix=/usr/local/samba --enable-selftest --sysconfdir=/etc/samba --with-ldap --with-ads --with-winbind && \
    make -j4 && \
    make install

# Configure
ENV PATH=/usr/local/samba/bin:/usr/local/samba/sbin:$PATH
COPY --chmod=700 BUILD/docker-entrypoint.sh /docker-entrypoint.sh

# Clean
RUN apt autoremove && apt clean && apt autoclean && \
    rm -r samba-$SAMBA_VERSION.tar.gz samba-$SAMBA_VERSION

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["samba"]
