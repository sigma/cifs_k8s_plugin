FROM flynn/busybox
MAINTAINER Yann Hodique <yann.hodique@gmail.com>
ENV UPDATED_AT 10-14-2016

COPY run.sh /tmp/bin/run.sh
COPY mount.cifs /tmp/bin/mount.cifs
COPY cifs.sh /tmp/bin/cifs.sh
COPY jq /tmp/bin/jq
WORKDIR /tmp/bin/

ENTRYPOINT ["/tmp/bin/run.sh"]
