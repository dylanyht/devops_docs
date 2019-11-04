# loki在k8s上的部署

> 前提：安装helm 因为此次方式是使用helm安装的

 

## 添加helm的chart库

```shell
helm repo add loki https://grafana.github.io/loki/charts
helm repo update
helm repo list
```

## 下载对应的chart包

> 下载下来解压  其中loki/loki-stack包含全部的  loki/loki只包含loki loki/promtail 可以选择安装

```shell
helm fetch loki/loki-stack
helm fetch loki/loki
helm fetch loki/promtail
```

## 安装和卸载命令

```shell
helm install --name  loki ./loki  --namespace=kube-system
helm install --name promtail ./promtail --set "loki.serviceName=loki"  --namespace=kube-system
helm delete --purge  loki
helm delete --purge   promtail
helm install ./loki-stack --name=loki-stack
helm delete --purge loki-stack
```
