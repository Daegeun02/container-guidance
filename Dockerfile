FROM nvidia/cuda:11.4.0-devel-ubuntu20.04

ARG DEBIAN_FRONTEND=noninteractive

## CUDA Environment
ENV PATH=/usr/local/cuda-11.4/bin:${PATH:+:${PATH}}
ENV LD_LIBRARY_PATH=/usr/local/cuda-11.4/lib64:${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

RUN apt-get update && apt-get -y install python3 git neovim python3-pip wget

## install and setup pycuda
RUN wget -P /usr/local/ https://files.pythonhosted.org/packages/5e/3f/5658c38579b41866ba21ee1b5020b8225cec86fe717e4b1c5c972de0a33c/pycuda-2019.1.2.tar.gz
RUN tar xvf /usr/local/pycuda-2019.1.2.tar.gz -C /usr/local/

RUN cd /usr/local/pycuda-2019.1.2 \ 
	&& python3 configure.py --cuda-root=/usr/local/cuda-11.4 \
	&& python3 setup.py install

## install something need
RUN pip3 uninstall serial
RUN pip3 install pyserial six numpy

## crazyflie setup
RUN git clone https://github.com/bitcraze/crazyflie-lib-python.git /usr/local/crazyflie-lib-python

ENV PYTHONPATH=/usr/local/crazyflie-lib-python

## conda install
# RUN wget -P ~/Downloads/ https://repo.anaconda.com/archive/Anaconda3-2022.10-Linux-aarch64.sh
# RUN bash ~/Downloads/Anaconda3-2022.10-Linux-aarch64.sh

## user setup
RUN apt-get install sudo

RUN \
	groupadd jarvis \
	&& useradd -ms /bin/bash jarvis -g jarvis \
	&& usermod -aG dialout jarvis \
	&& echo "jarvis ALL=NOPASSWD: ALL" >> /etc/sudoers

USER jarvis
WORKDIR /home/jarvis
