# 镜像说明
此镜像为基于ubuntu16.04安装的Python3.6的环境
其中requirements.txt为Python安装的依赖  如果不需要可以不用
sources.list为apt源文件 这里是更换为阿里云的源
镜像打为：docker build -t registry.cn-qingdao.aliyuncs.com/dylanyht/ubuntu:py36 .