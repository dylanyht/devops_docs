- 此镜像是基于dylan123/jdk-centos7:1.8.0_151制作的

操作内容

​    增加了promtail，以供以后连接loki来抓取日志，

   注意：bin的promtail是启动脚本 dockerfile中的本目录的下的promtail是程序 需要下载[电梯直达](https://github.com/grafana/loki/releases/download/v0.4.0/promtail-linux-amd64.gz)

   本镜像指放入了promtail程序和启动脚本  没有放入promtail的配置文件 可以按需要自己添加promtail-local-config.yaml    如果需要配置容器启动时启动promtail 在启动脚本中加入此命令：/etc/init.d/promtail start
构建后的镜像名为：dylan123/promtail-centos7:jdk-1.8.0_151