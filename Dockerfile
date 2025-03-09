FROM nvidia/cuda:12.4.1-devel-ubuntu20.04

ARG DEBIAN_FRONTEND=noninteractive

## CUDA Environment
ENV PATH=/usr/local/cuda-12.4/bin:${PATH:+:${PATH}}
ENV LD_LIBRARY_PATH=/usr/local/cuda-12.4/lib64:${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

RUN apt-get update && apt-get -y install python3 git neovim python3-pip wget

RUN pip install pycuda --verbose

RUN pip install cudg

## install something need
RUN pip uninstall serial
RUN pip install pyserial six numpy

## user setup
RUN apt-get install sudo

RUN groupadd jarvis \
	&& useradd -ms /bin/bash jarvis -g jarvis \
	&& usermod -aG dialout jarvis \
	&& echo "jarvis ALL=NOPASSWD: ALL" >> /etc/sudoers

RUN cd /home/jarvis \
	&& mkdir workspace

USER jarvis
WORKDIR /home/jarvis/workspace
