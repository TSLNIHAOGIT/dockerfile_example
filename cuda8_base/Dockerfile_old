FROM nvidia/cuda:8.0-cudnn5-devel-ubuntu16.04
MAINTAINER tsl <tsl@gmail.com>

RUN rm /etc/apt/sources.list
# RUN rm /etc/apt/sources.list.d/cuda.list

COPY sources.list  /etc/apt/
# 教育网用清华，其他网就用网易或者阿里
# COPY tuna-srclist /etc/apt/sources.list
# ADD /etc/apt/sources.list /etc/apt/
COPY requirements.txt /tmp/

##安装相关依赖,这些依赖基本上不会变动
RUN apt-get update && \
    apt-get install -y --no-install-recommends  openssl libssl-dev  libc6-dev gcc g++ vim  git \ 
    make build-essential zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm tk-dev && \
	wget -O - https://www.python.org/ftp/python/3.6.5/Python-3.6.5.tgz  | tar zxf - && \
	cd /Python-3.6.5/ && \
    ./configure --prefix=/usr/local/python3 --enable-optimizations && \
    make && \
	make install && \
	wget -O - https://cmake.org/files/v3.3/cmake-3.3.2.tar.gz | tar zxf - && \
	ln -s /usr/local/python3/bin/python3.6 /usr/bin/python3 && \
    ln -s /usr/local/python3/bin/pip3 /usr/bin/pip3 && \
	pip3 install -U pip 

#安装的python库可能会新增，因此放在后面，前面的可以重用
RUN	apt-get update  -y --no-install-recommends && \
    pip3 install -r /tmp/requirements.txt -i https://pypi.douban.com/simple && \
	##删除不需要的文件
	rm -rf /var/lib/apt/lists/*  ~/.cache/pip && \
	apt-get autoclean && \
	apt-get clean && \
    apt-get autoremove 
WORKDIR /ai
