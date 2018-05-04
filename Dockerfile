FROM jenkins/jenkins:lts

USER root

RUN apt-get update -y && \
	apt-get upgrade -y

RUN apt-get install -y software-properties-common
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 5BB92C09DB82666C  

RUN apt-get install -y \
    make \
	build-essential \
	libssl-dev \
	zlib1g-dev \
	libncurses5-dev \
	libncursesw5-dev \
	libreadline-dev \
	libsqlite3-dev \
	libgdbm-dev \
	libdb5.3-dev \
	libbz2-dev \
	libexpat1-dev \
	liblzma-dev \
	tk-dev \
	wget

COPY install_python3_6.sh /root/tmp/install_python3_6.sh

RUN chmod +x /root/tmp/install_python3_6.sh; sync && \
	./root/tmp/install_python3_6.sh && \
	rm -rf /root/tmp/install_python3_6.sh && \
	ln -s /Python-3.6.1/python /usr/bin/python3.6

RUN rm -rf /usr/local/lib/python3.6/site-packages/pip* && \
	wget https://bootstrap.pypa.io/get-pip.py && \
	python3.6 get-pip.py && \
	rm get-pip.py

# very important
#USER jenkins    