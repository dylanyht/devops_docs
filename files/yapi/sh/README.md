# yapi说明文档

> 此文档的前提得提前启动好mongodb的容器

## 安装yapi

> 因为yapi安装需要web端操作所以没办法直接写入镜像

容器启动后进入以下操作

```shell
cd /
./install.sh
```

然后按照提示web端访问ip:9090 填入对应的所需信息 等待安装安装

## 启动yapi

在安装完成后 会提示以下内容

```
log: mongodb load success...

 初始化管理员账号成功,账号名："admin@admin.com"，密码："ymfe.org"

部署成功，请切换到部署目录，输入： "node vendors/server/app.js" 指令启动服务器, 然后在浏览器打开 http://127.0.0.1:3000 访问
```

然后执行一下操作

```shell
cd /
./run.sh
```

然后访问ip:3000

账号密码为：admin@admin.com    ymfe.org

