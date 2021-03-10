FROM ubuntu:16.04

LABEL maintainer="dylan.yht@outlook.com"

ADD sources.list /etc/apt/
COPY requirements.txt /

RUN apt-get update -y \
&& apt-get install zip libgl1-mesa-dev libglib2.0-dev -y \
&& apt-get install gcc -y\
&& apt-get install g++ -y\
&& apt-get install gdb -y\
&& apt-get install python-software-properties -y\
&& apt-get install software-properties-common -y\
&& sh -c '/bin/echo -e "\n" | add-apt-repository ppa:deadsnakes/ppa'\
&& apt-get update -y\
&& apt-get install python3.6 -y\
&& rm /usr/bin/python\
&& ln -s /usr/bin/python3.6 /usr/bin/python\
&& rm /usr/bin/python3\
&& ln -s /usr/bin/python3.6 /usr/bin/python3\
&& apt-get install python3-pip -y\
&& pip3 install pip -U\
&& rm /usr/bin/pip3 \
&& ln -s -f /usr/local/bin/pip3 /usr/bin/pip3\
&& ln -s -f /usr/local/bin/pip3 /usr/bin/pip\
&& pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple\
&& pip install -r /requirements.txt