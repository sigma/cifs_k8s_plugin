FROM flynn/busybox
MAINTAINER Yann Hodique <yann.hodique@gmail.com>
ENV UPDATED_AT 07-09-2015

COPY run.sh /tmp/bin/run.sh
COPY mount.cifs /tmp/bin/mount.cifs
WORKDIR /tmp/bin/

ENTRYPOINT ["/tmp/bin/run.sh"]