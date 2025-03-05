FROM nvidia/cuda:12.4.1-devel-ubuntu20.04

ARG DEBIAN_FRONTEND=noninteractive

## CUDA Environment
ENV PATH=/usr/local/cuda-11.4/bin:${PATH:+:${PATH}}
ENV LD_LIBRARY_PATH=/usr/local/cuda-11.4/lib64:${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

RUN apt-get update && apt-get -y install python3 git neovim python3-pip wget

RUN pip3 install pycuda --verbose

RUN cd /usr/local \
    && git clone https://github.com/Daegeun02/cudg.git

RUN echo "export PYTHONPATH=/usr/local/cudg:${PYTHONPATH:+:${PYTHONPATH}}" >> ~/.bashrc

## install something need
RUN pip3 uninstall serial
RUN pip3 install pyserial six numpy

## user setup
RUN apt-get install sudo

RUN \
	groupadd jarvis \
	&& useradd -ms /bin/bash jarvis -g jarvis \
	&& usermod -aG dialout jarvis \
	&& echo "jarvis ALL=NOPASSWD: ALL" >> /etc/sudoers

USER jarvis
WORKDIR /home/jarvis
