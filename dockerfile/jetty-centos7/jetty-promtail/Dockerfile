FROM dylan123/promtail-centos7:jdk-1.8.0_151

LABEL maintainer="dylan.yht@outlook.com"


COPY jetty-distribution-9.4.24.v20191120.zip /

RUN cd / \
&&  yum install -y unzip which \
&& unzip jetty-distribution-9.4.24.v20191120.zip \
&& mv jetty-distribution-9.4.24.v20191120 jetty

WORKDIR /jetty

ENV JETTY_HOME=/jetty