FROM docker.repository.cloudera.com/cdsw/cuda-engine:10

RUN rm /etc/apt/sources.list.d/*

##install necessary libraries
RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get -y install build-essential \
        zlib1g-dev \
        libncurses5-dev \
        libgdbm-dev \ 
        libnss3-dev \
        libssl-dev \
        libreadline-dev \
        libffi-dev \
        libsqlite3-dev \
        libbz2-dev \
        wget \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get purge -y imagemagick imagemagick-6-common 

##install python3.11
RUN cd /usr/src \
    && wget https://www.python.org/ftp/python/3.11.0/Python-3.11.0.tgz \
    && tar -xzf Python-3.11.0.tgz \
    && cd Python-3.11.0 \
    && ./configure --enable-optimizations \
    && make altinstall

##change sysmlink python3
RUN update-alternatives --install /usr/local/bin/python3 python3 /usr/local/bin/python3.11 1
RUN update-alternatives --config python3

##change sysmlink pip3
RUN update-alternatives --install /usr/local/bin/pip3 pip3 /usr/local/bin/pip3.11 1
RUN update-alternatives --config pip3

#RUN apt install -y python3.11-dev python3.11-venv python3.11-distutils python3.11-lib2to3 python3.11-gdbm python3.11-tk

##install python3.11 using deadsnakes repo 
#RUN apt update -y
#RUN apt-get update -y

#RUN apt install software-properties-common -y
#RUN add-apt-repository ppa:deadsnakes/ppa

#RUN apt install -y python3.9  python3.9-distutils && rm /etc/apt/sources.list.d/*
#RUN update-alternatives --install /usr/local/bin/python3 python3 /usr/bin/python3.9 1
#RUN update-alternatives --config python3
#RUN ln -s /usr/bin/python3.11 /usr/local/bin/python3
 
#install other necessary package 
RUN apt install curl
RUN apt install ffmpeg -y

#install necessary python libraries
RUN pip3 install --upgrade pip
RUN pip3 install pandas numpy notebook 



