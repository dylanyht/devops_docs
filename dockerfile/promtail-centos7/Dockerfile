FROM dylan123/jdk-centos7:1.8.0_151

LABEL maintainer="dylan.yht@outlook.com"

COPY  ./bin/promtail /
COPY  ./bin/functions /
COPY  promtail /opt/


RUN cd / \
&& yum install -y initscripts \
&& mv promtail /etc/init.d/ \
&& mv functions /etc/init.d/ \