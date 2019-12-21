# centos7安装loki及promtail

> 系统版本centos7.6 
>
> loki版本0.4.0
>
> promtail版本0.4.0

## 下载loki、promtail

```shell
wget https://github.com/grafana/loki/releases/download/v0.4.0/loki-linux-amd64.gz
wget https://github.com/grafana/loki/releases/download/v0.4.0/promtail-linux-amd64.gz
```

## 解压

> 解压并移动位置

```shell
#loki
mkdir /usr/local/loki
gunzip loki-linux-amd64.gz
chmod +x loki-linux-amd64
mv loki-linux-amd64 loki
mv loki /usr/local/loki

#promt
mkdir /usr/local/promtail
gunzip promtail-linux-amd64.gz
chmod +x promtail-linux-amd64
mv promtail-linux-amd64 promtail
mv promtail /usr/local/promtail
```

## 配置loki

```shell
cd /usr/local/loki
vim loki-local-config.yaml
# 写入以下内容
auth_enabled: false

server:
  http_listen_port: 3100

ingester:
  lifecycler:
    address: 127.0.0.1
    ring:
      kvstore:
        store: inmemory
      replication_factor: 1
    final_sleep: 0s
  chunk_idle_period: 5m
  chunk_retain_period: 30s
  max_transfer_retries: 1

schema_config:
  configs:
  - from: 2018-04-15
    store: boltdb
    object_store: filesystem
    schema: v9
    index:
      prefix: index_
      period: 168h

storage_config:
  boltdb:
    directory: /tmp/loki/index

  filesystem:
    directory: /tmp/loki/chunks

limits_config:
  enforce_metric_name: false
  reject_old_samples: true
  reject_old_samples_max_age: 168h

chunk_store_config:
  max_look_back_period: 0

table_manager:
  chunk_tables_provisioning:
    inactive_read_throughput: 0
    inactive_write_throughput: 0
    provisioned_read_throughput: 0
    provisioned_write_throughput: 0
  index_tables_provisioning:
    inactive_read_throughput: 0
    inactive_write_throughput: 0
    provisioned_read_throughput: 0
    provisioned_write_throughput: 0
  retention_deletes_enabled: false
  retention_period: 0

```

## 静态配置promtail

```shell
cd /usr/local/promtail
vim promtail-local-config.yaml
# 写入以下内容
server:
  http_listen_port: 9080
  grpc_listen_port: 0

positions:
  filename: /tmp/positions.yaml

clients:
  - url: http://localhost:3100/loki/api/v1/push

scrape_configs:
- job_name: system
  static_configs:
  - targets:
      - localhost
    labels:
      job: varlogs
      __path__: /var/log/*
```

## 基于文件的服务发现配置promtail

> 和静态配置promtail二选一即可

```shell
cd /usr/local/promtail/
vim promtail-local-config.yaml
#写入一下内容

server:
  http_listen_port: 9080
  grpc_listen_port: 0

positions:
  filename: /tmp/positions.yaml

clients:
  - url: http://localhost:3100/loki/api/v1/push

scrape_configs:
- job_name: order
  file_sd_configs:
    - files:
      - /usr/local/promtail/config/*.yaml
      refresh_interval: 5s #更新的间隔 默认是5m
      
```

```shell
#创建存放配置的目录
mkdir config
vim ./config/ceshi.yaml
#写入一下内容
  - targets:
      - localhost
    labels:
      job: varlogs
      __path__: /var/log/*
```

## 启动

- loki

```shell
cd /usr/local/loki
./loki -config.file=loki-local-config.yaml
```

- promtail

```shell
cd /usr/local/promtail
./promtail -config.file=promtail-local-config.yaml
```

## 配置系统服务

- loki

```shell
vim /etc/systemd/system/loki.service

# 写入以下内容

[Unit]
Description=loki
Wants=network-online.target
After=network-online.target
[Service]
Restart=on-failure
ExecStart=/usr/local/loki/loki --config.file=/usr/local/loki/loki-local-config.yaml
[Install]
WantedBy=multi-user.target
```

- promtail

```shell
vim /etc/systemd/system/promtail.service
#写入以下内容


[Unit]
Description=promtail
Wants=network-online.target
After=network-online.target
[Service]
Restart=on-failure
ExecStart=/usr/local/promtail/promtail --config.file=/usr/local/promtail/promtail-local-config.yaml
[Install]
WantedBy=multi-user.target
```

配置好均需要执行以下命令

```shell
systemctl daemon-reload
```

## 相关启动、停止命令

```shell
systemctl start loki.service
systemctl status loki.service
systemctl stop loki.service
systemctl restart loki.service

systemctl start  promtail.service
systemctl status  promtail.service
systemctl restart  promtail.service
systemctl stop  promtail.service
```

至此 loki和promtail安装完成 ，后续可以加入grafana中。