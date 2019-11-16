FROM centos
##设置java环境变量
ENV TZ=Asia/Shanghai  LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV JAVA_HOME=/opt/java/jdk1.8.0_171 JRE_HOME=/opt/java/jdk1.8.0_171/jre 
ENV CLASS_PATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib
ENV PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin

##会将压缩文件自动解压到该文件夹下
ADD  jdk-8u171-linux-x64.tar.gz  /opt/java/
WORKDIR /ai
