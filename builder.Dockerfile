FROM fedora:22
MAINTAINER Yann Hodique <yann.hodique@gmail.com>
ENV UPDATED_AT 07-09-2015

#install required libraries & clean up to keep thin layer
RUN dnf groupinstall -y "Development Tools" "Development Libraries" \
    && dnf install -y bzip2 tar \
    && dnf autoremove -y && dnf clean all -y

#download & make mount.cifs from source
RUN (cd /tmp; curl -LO -o cifs-utils-6.4.tar.bz2 http://ftp.samba.org/pub/linux-cifs/cifs-utils/cifs-utils-6.4.tar.bz2) \
    && (cd /tmp; tar -xf cifs-utils-6.4.tar.bz2; rm cifs-utils-6.4.tar.bz2) \ 
    && (cd /tmp/cifs-utils-6.4/; ./configure && make) \
    && mkdir -p /tmp/bin/ \
    && cp /tmp/cifs-utils-6.4/mount.cifs /tmp/bin/

#prepare WORKDIR
COPY run.Dockerfile /tmp/bin/Dockerfile
COPY run.sh /tmp/bin/run.sh
WORKDIR /tmp/bin/

# Export the WORKDIR as a tar stream
CMD tar -cf - .