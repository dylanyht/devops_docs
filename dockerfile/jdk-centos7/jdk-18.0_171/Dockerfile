
FROM centos:7.6.1810

LABEL maintainer="dylan.yht@outlook.com"

COPY jdk-8u171-linux-x64.tar.gz /

RUN cd / \
&& tar -zxvf jdk-8u171-linux-x64.tar.gz -C /opt/ \
&& rm -rf jdk-8u171-linux-x64.tar.gz \
&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& echo "Asia/Shanghai" >> /etc/timezone

ENV JAVA_HOME=/opt/jdk1.8.0_171
ENV JAVA_BIN=/opt/jdk1.8.0_171/bin
ENV PATH=$JAVA_HOME/bin:$PATH
ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    LC_CTYPE=en_US.UTF-8