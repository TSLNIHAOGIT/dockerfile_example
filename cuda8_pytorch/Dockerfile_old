FROM cuda8_base
MAINTAINER tsl <tsl@gmail.com>
##里面有第三方源，这个不需要
RUN rm /etc/apt/sources.list.d/*
WORKDIR /ai
RUN apt-get update && \
    wget -O - https://cmake.org/files/v3.3/cmake-3.3.2.tar.gz | tar zxf - && \
	cd cmake-3.3.2/ && \
    ./bootstrap && \
	make && \
	make install && \
	cd /ai && \
	git clone https://github.com/SeanNaren/warp-ctc.git && \
	cd warp-ctc/ && \
	mkdir build && \
	cd build && \
	cmake ..  && \
	make && \
	cd .. && \
	cd pytorch_binding && \
	python3 setup.py install && \
	rm -rf /var/lib/apt/lists/*  ~/.cache/pip && \
	apt-get autoclean && \
	apt-get clean && \
    apt-get autoremove
