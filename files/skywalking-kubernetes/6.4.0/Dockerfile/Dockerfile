FROM  apache/skywalking-oap-server:6.4.0

# 时区修改为东八区
RUN apk add --no-cache tzdata
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


COPY mysql-connector-java-5.1.48/*  /skywalking/oap-libs/
