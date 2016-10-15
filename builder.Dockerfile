FROM fedora:22
MAINTAINER Yann Hodique <yann.hodique@gmail.com>
ENV UPDATED_AT 10-14-2016

#install required libraries & clean up to keep thin layer
RUN dnf groupinstall -y "Development Tools" "Development Libraries" \
    && dnf install -y bzip2 tar libtool flex bison glibc-static \
    && dnf autoremove -y && dnf clean all -y

#download & make mount.cifs from source
RUN (cd /tmp; curl -Lo cifs-utils.tar.bz2 http://ftp.samba.org/pub/linux-cifs/cifs-utils/cifs-utils-6.5.tar.bz2) \
    && (cd /tmp; mkdir cifs-utils; tar -xf cifs-utils.tar.bz2 -C cifs-utils --strip-components=1; rm cifs-utils.tar.bz2) \ 
    && (cd /tmp/cifs-utils/; ./configure && make -j) \
    && mkdir -p /tmp/bin/ \
    && cp /tmp/cifs-utils/mount.cifs /tmp/bin/

#download & make jq from source
RUN (cd /tmp; curl -Lo jq.tar.gz https://github.com/stedolan/jq/releases/download/jq-1.5/jq-1.5.tar.gz) \
    && (cd /tmp; mkdir jq; tar -xf jq.tar.gz -C jq --strip-components=1; rm jq.tar.gz) \
    && (cd /tmp/jq/; autoreconf -i && ./configure --enable-all-static && make -j) \
    && mkdir -p /tmp/bin/ \
    && ls /tmp/jq \
    && cp /tmp/jq/jq /tmp/bin/

#prepare WORKDIR
COPY run.Dockerfile /tmp/bin/Dockerfile
COPY cifs.sh /tmp/bin/cifs.sh
COPY run.sh /tmp/bin/run.sh
WORKDIR /tmp/bin/

# Export the WORKDIR as a tar stream
CMD tar -cf - .
