# centos7增加swap大小

> 因为业务需求需要增加swap， 此文档做一下记录。

## 创建一个大小为5G的文件

> 注意：如果你的系统是一路默认安装的， 那文件系统一般是xfs。  如果是xfs的文件系统，不要使用fallocate来创建swap文件，会报错的。fallocate对于ext4各版本的支持都没什么问题，但是对于xfs不友好。

```shell
[root@k8s-77-43 ~]# df -T | awk '{print $1,$2,$NF}' | grep "^/dev" #查看文件系统
/dev/mapper/centos-root xfs /
/dev/mapper/centos-home xfs /home
/dev/sda1 xfs /boot
[root@k8s-77-43 /]# dd if=/dev/zero of=/swapfile bs=1G count=5
5+0 records in
5+0 records out
5368709120 bytes (5.4 GB) copied, 8.90435 s, 603 MB/s
```

## 将文件变为swap文件

```shell
[root@k8s-77-43 ~]# mkswap /swapfile
Setting up swapspace version 1, size = 5242876 KiB
no label, UUID=86ff8b5b-1637-4fda-aa45-0d8c798e4cb5
[root@k8s-77-43 ~]# chmod 600 /swapfile  #设置文件权限
```

## 启用文件

```shell
[root@k8s-77-43 ~]# swapon /swapfile
[root@k8s-77-43 ~]# free -h  #查看swap已经增加
              total        used        free      shared  buff/cache   available
Mem:            15G        935M        9.2G         22M        5.4G         14G
Swap:           12G         37M         12G
```

## 设置开机自动挂载

```shell
[root@k8s-77-43 ~]# vim /etc/fstab
...
/swapfile    swap    swap    default   0 0
```

***至此，swap增加完毕***