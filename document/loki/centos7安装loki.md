# centos7安装loki

> 系统版本centos7.6 
>
> loki版本0.4.0

## 下载loki、promtail

```shell
wget https://github.com/grafana/loki/releases/download/v0.4.0/loki-linux-amd64.gz
wget https://github.com/grafana/loki/releases/download/v0.4.0/promtail-linux-amd64.gz
```

## 解压

> 解压并移动位置

```shell
mkdir /usr/local/loki
mkdir /usr/local/promtail
gunzip loki-linux-amd64.gz
gunzip promtail-linux-amd64.gz
chmod +x loki-linux-amd64 promtail-linux-amd64
mv loki-linux-amd64 loki && mv promtail-linux-amd64 promtail
mv loki /usr/local/loki
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

## 配置promtail

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