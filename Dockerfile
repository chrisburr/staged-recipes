FROM centos:5

RUN yum -y install wget bzip2

RUN wget https://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh && \
    bash Miniconda-latest-Linux-x86_64.sh -b && \
    rm Miniconda-latest-Linux-x86_64.sh

ENV PATH=/root/miniconda2/bin:$PATH

RUN conda install -y conda-build

RUN yum install -y glibc-devel make libX11-devel libXpm-devel libXft-devel libXext-devel libGLU-devel patch
