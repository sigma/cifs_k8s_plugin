FROM fedora
MAINTAINER Yann Hodique <yann.hodique@gmail.com>
ENV UPDATED_AT 01-16-2015

RUN yum groupinstall -y "Development Tools" "Development Libraries"
RUN yum install -y bzip2 tar
WORKDIR /tmp
RUN curl -LO http://ftp.samba.org/pub/linux-cifs/cifs-utils/cifs-utils-6.4.tar.bz2
RUN tar -xf cifs-utils-6.4.tar.bz2
WORKDIR /tmp/cifs-utils-6.4/
RUN ./configure
RUN make

ADD run.sh /tmp/run.sh

ENTRYPOINT ["/tmp/run.sh"]
