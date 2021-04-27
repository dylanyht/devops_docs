- 此镜像在centos：7.6.1810基础上制作

  操作内容

​        增加jdk-8u201 打镜像之前需要在与Dockerfile同目录下放置jdk-8u171-linux-x64.tar.gz
        增加apache-tomcat-8.5.64 打镜像之前需要在与Dockerfile通目录下放置apache-tomcat-8.5.64.tar.gz


​

​        修改了时区及字符
 构建后的镜像名为：dylan123/tomcat8-centos7:8.5.64