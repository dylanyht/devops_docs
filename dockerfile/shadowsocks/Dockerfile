FROM centos:centos7

LABEL maintainer="dylan.yht@outlook.com"

COPY get-pip.py /
COPY docker-entrypoint.sh /
COPY  shadowsocks.json /etc/

WORKDIR /

RUN yum -y install epel-release \
&& yum install python-pip wget lsof -y \
&& python get-pip.py \
&& pip install -U pip \
&& pip install shadowsocks

EXPOSE 1080

ENTRYPOINT ["/docker-entrypoint.sh"]
