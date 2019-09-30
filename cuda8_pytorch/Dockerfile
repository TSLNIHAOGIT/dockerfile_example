FROM cuda8_base
MAINTAINER tsl <tsl@gmail.com>
##设置语言为中文
ENV TZ=Asia/Shanghai LANG=C.UTF-8 LC_ALL=C.UTF-8
WORKDIR /ai
COPY waitress-serve  /usr/bin
##里面有第三方源，这个不需要
#RUN rm /etc/apt/sources.list.d/* && \
RUN    apt-get update && \
    apt-get install -y --no-install-recommends tesseract-ocr && \
    wget -O - https://cmake.org/files/v3.3/cmake-3.3.2.tar.gz | tar zxf - && \
	cd cmake-3.3.2/ && \
    ./bootstrap && \
	make && \
	make install && \
        pip3 install http://download.pytorch.org/whl/cu80/torch-1.0.1.post2-cp36-cp36m-linux_x86_64.whl torchvision -i https://pypi.douban.com/simple && \
	cd .. && \
	git clone https://github.com/SeanNaren/warp-ctc.git && \
	cd warp-ctc/ && \
	mkdir build && \
	cd build && \
	cmake ..  && \
	make && \
	cd .. && \
	cd pytorch_binding && \
	python3 setup.py install && \
	cd /usr/bin && \
	chmod 777 waitress-serve

COPY requirements.txt /tmp/
#安装的python库可能会新增，因此放在后面，前面的可以重用
RUN	apt-get update  && \
    pip3 install -r /tmp/requirements.txt -i https://pypi.douban.com/simple && \
	##删除不需要的文件
	rm -rf /var/lib/apt/lists/*  ~/.cache/pip && \
	apt-get autoclean && \
	apt-get clean && \
    apt-get autoremove 	
