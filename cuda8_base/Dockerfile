FROM nvidia/cuda:8.0-cudnn5-devel-ubuntu16.04
MAINTAINER tsl <tsl@gmail.com>
##设置时间为cts时间，##设置语言为中文
ENV TZ Asia/Shanghai  LANG C.UTF-8 LC_ALL=C.UTF-8
#设置docker工作目录
WORKDIR /ai

# 添加阿里云apt源,注释不能写到和命令同一行
COPY sources.list  /etc/apt/ 
# 教育网用清华，其他网就用网易或者阿里


##删除第三方源文件，安装相关依赖,这些依赖基本上不会变动，已经python3.6.5和pip3
RUN rm /etc/apt/sources.list.d/* && \
    apt-get update && \
    apt-get install -y --no-install-recommends  openssl libssl-dev  libc6-dev gcc g++ vim  git \ 
    make build-essential zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm tk-dev && \
	wget -O - https://www.python.org/ftp/python/3.6.5/Python-3.6.5.tgz  | tar zxf - && \
	cd ./Python-3.6.5/ && \
    ./configure --prefix=/usr/local/python3 --enable-optimizations && \
    make && \
	make install && \
	ln -s /usr/local/python3/bin/python3.6 /usr/bin/python3 && \
    ln -s /usr/local/python3/bin/pip3 /usr/bin/pip3 && \
	pip3 install -U pip -i https://pypi.douban.com/simple

COPY requirements.txt /tmp/
#安装的python库可能会新增，因此放在后面，前面的可以重用
RUN	apt-get update  && \
    pip3 install -r /tmp/requirements.txt -i https://pypi.douban.com/simple && \
	##删除不需要的文件
	rm -rf /var/lib/apt/lists/*  ~/.cache/pip && \
	apt-get autoclean && \
	apt-get clean && \
    apt-get autoremove 
