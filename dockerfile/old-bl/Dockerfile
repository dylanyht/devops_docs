FROM 172.16.77.53:30882/centos7-tools-jdk8-git:0.0.3

COPY jetty-distribution-9.4.24.v20191120.zip /
COPY profile /

RUN cd /  \
&& yum install -y unzip which\
&& cat profile >> /etc/profile \
&& unzip jetty-distribution-9.4.24.v20191120.zip \
&& rm -rf jetty-distribution-9.4.24.v20191120.zip \
&& mv jetty-distribution-9.4.24.v20191120 jetty \
&& localedef -v -c -i en_US -f UTF-8 en_US.UTF-8; exit 0

ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    LC_CTYPE=en_US.UTF-8