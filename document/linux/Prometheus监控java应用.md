# Prometheus监控java应用

> 使用jmx_exporter来监控tomcat,并推送给Prometheus。 此文档用来记录一下
>
> tomcat已经安装好的  不再安装
>
> 项目地址：[电梯直达](https://github.com/prometheus/jmx_exporter)

## 下载jmx_exporter

```shell
wget https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.12.0/jmx_prometheus_javaagent-0.12.0.jar
mkdir /usr/local/jmx 
mv jmx_prometheus_javaagent-0.12.0.jar /usr/local/jmx/
```

## 编写jmx_exporter配置文件

```shell
cd /usr/local/jmx/
# 也可以下载官方配置修改 https://github.com/prometheus/jmx_exporter/blob/master/example_configs/tomcat.yml
vim tomcat.yml
# 写入以下内容
---
lowercaseOutputLabelNames: true
lowercaseOutputName: true
rules:
- pattern: 'Catalina<type=GlobalRequestProcessor, name=\"(\w+-\w+)-(\d+)\"><>(\w+):'
  name: tomcat_$3_total
  labels:
    port: "$2"
    protocol: "$1"
  help: Tomcat global $3
  type: COUNTER
- pattern: 'Catalina<j2eeType=Servlet, WebModule=//([-a-zA-Z0-9+&@#/%?=~_|!:.,;]*[-a-zA-Z0-9+&@#/%=~_|]), name=([-a-zA-Z0-9+/$%~_-|!.]*), J2EEApplication=none, J2EEServer=none><>(requestCount|maxTime|processingTime|errorCount):'
  name: tomcat_servlet_$3_total
  labels:
    module: "$1"
    servlet: "$2"
  help: Tomcat servlet $3 total
  type: COUNTER
- pattern: 'Catalina<type=ThreadPool, name="(\w+-\w+)-(\d+)"><>(currentThreadCount|currentThreadsBusy|keepAliveCount|pollerThreadCount|connectionCount):'
  name: tomcat_threadpool_$3
  labels:
    port: "$2"
    protocol: "$1"
  help: Tomcat threadpool $3
  type: GAUGE
- pattern: 'Catalina<type=Manager, host=([-a-zA-Z0-9+&@#/%?=~_|!:.,;]*[-a-zA-Z0-9+&@#/%=~_|]), context=([-a-zA-Z0-9+/$%~_-|!.]*)><>(processingTime|sessionCounter|rejectedSessions|expiredSessions):'
  name: tomcat_session_$3_total
  labels:
    context: "$2"
    host: "$1"
  help: Tomcat session $3 total
  type: COUNTER
- pattern: ".*"  #让所有的jmx metrics全部暴露出来
```

## 配置启动参数

> java应用一般两种启动方式。  一种是jar包启动方式，一种是tomcat方式

```shell
# jar包方式启动
java -javaagent:/usr/local/jmx/jmx_prometheus_javaagent-0.12.0.jar=38081:/usr/local/jmx/tomcat.yml -jar yourJar.jar
# tomcat启动 需要配置catalina.sh 我们是用catalina.sh来启动tomcat的  
vim  your-tomcat/bin/catalina.sh
  #加入以下内容
JAVA_OPTS="-javaagent:/usr/local/jmx/jmx_prometheus_javaagent-0.12.0.jar=38081:/usr/local/jmx/tomcat.yml"

#如果你是使用startup.sh来启动tomcat 可以配置setenv.sh文件
#注意setenv.sh和catalina.sh 二选一配置  不要配置重复了
cat > your-tomcat/bin/setenv.sh << EOF
JAVA_OPTS="-javaagent:/usr/local/jmx/jmx_prometheus_javaagent-0.12.0.jar=38081:/usr/local/jmx/tomcat.yml"
EOF

#配置好 重启tomcat
web访问http://<your-ip>:38081 即可看到监控的指标
```

## Prometheus配置

```yaml
## prometheus.yml文件配置
 - job_name: 'tomcat'
    static_configs:
    - targets: ['172.16.7.124:38081']
      labels:
        appname: 'tomcat'
```

## grafana配置

关于jmx的监控，grafana官方有个模板提供[电梯直达](https://grafana.com/grafana/dashboards/8563)，导入grafana中，稍微修改就可使用

完成图展示：

[![MGryc9.md.png](https://s2.ax1x.com/2019/11/13/MGryc9.md.png)](https://imgchr.com/i/MGryc9)