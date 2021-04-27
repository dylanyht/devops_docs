FROM centos:7.6.1810

LABEL maintainer="dylan.yht@outlook.com"

COPY jdk-8u201-linux-x64.tar.gz /
COPY apache-tomcat-8.5.64.tar.gz /

ENV LANG=zh_CN.UTF-8 \
    LANGUAGE=zh_CN:zh \
    LC_ALL=zh_CN.UTF-8

RUN cd / \
&&  yum update -y \
&&  yum reinstall -y glibc-common kde-l10n-Chinese  \
&&  yum install -y telnet net-tools  \
&&  yum clean all  \
&&  rm -rf /tmp/* rm -rf /var/cache/yum/*  \
&&  localedef -c -f UTF-8 -i zh_CN zh_CN.UTF-8  \
&&  ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& echo "Asia/Shanghai" >> /etc/timezone \
&& tar -zxvf jdk-8u201-linux-x64.tar.gz -C /opt/ \
&& rm -rf jdk-8u201-linux-x64.tar.gz \
&& tar -zxvf  apache-tomcat-8.5.64.tar.gz -C /opt/ \
&& mv /opt/apache-tomcat-8.5.64/ /opt/tomcat  \
&& rm -rf apache-tomcat-8.5.64.tar.gz \
&& cp /opt/jdk1.8.0_201/lib/tools.jar /opt/tomcat/lib/

ENV JAVA_HOME=/opt/jdk1.8.0_201
ENV JAVA_BIN=/opt/jdk1.8.0_201/bin
ENV JAVA_JRE=$JAVA_HOME/jre
ENV CLASS_PATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib
ENV PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin