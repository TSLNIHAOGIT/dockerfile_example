FROM cuda8_base
MAINTAINER tsl <tsl@gmail.com>
##设置java环境变量
ENV TZ=Asia/Shanghai  LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV JAVA_HOME=/opt/java/jdk1.8.0_171 JRE_HOME=/opt/java/jdk1.8.0_171/jre 
ENV CLASS_PATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib
ENV PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin

##会将压缩文件自动解压到该文件夹下
ADD  jdk-8u171-linux-x64.tar.gz  /opt/java/

COPY requirements.txt /tmp/
#安装的python库可能会新增，因此放在后面，前面的可以重用
RUN	apt-get update  && \
    pip3 install -r /tmp/requirements.txt -i https://pypi.douban.com/simple && \
	##删除不需要的文件
	rm -rf /var/lib/apt/lists/*  ~/.cache/pip && \
	apt-get autoclean && \
	apt-get clean && \
    apt-get autoremove 	
