FROM ubuntu:18.04
ENV LANG C.UTF-8
RUN APT_INSTALL="apt-get install -y --no-install-recommends" && \
    PIP_INSTALL="python -m pip --no-cache-dir install --upgrade" && \
    GIT_CLONE="git clone --depth 10" && \
  
    rm -rf /var/lib/apt/lists/* \
           /etc/apt/sources.list.d/cuda.list \
           /etc/apt/sources.list.d/nvidia-ml.list && \
    # apt source
    rm -rf /etc/apt/sources.lists && \
    touch /etc/apt/sources.lists    && \
    
    echo deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse > /etc/apt/sources.list && \
    echo deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse >> /etc/apt/sources.list && \
    echo deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse >> /etc/apt/sources.list && \
    echo deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse >> /etc/apt/sources.list && \
    echo deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse >> /etc/apt/sources.list && \

    apt-get update && \

# ==================================================================
# tools
# ------------------------------------------------------------------

    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        build-essential \
        apt-utils \
        ca-certificates \
        wget \
        git \
        vim \
        libssl-dev \
        curl \
        unzip \
        unrar \
        zsh \
        ttf-wqy-microhei  \
        ttf-wqy-zenhei    \
        xfonts-wqy       \
        && \  
# ==================================================================
# python
# ------------------------------------------------------------------

    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        software-properties-common \
        && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        python3.6 \
        python3.6-dev \
        python3-distutils-extra \
        tk-dev \ 
        python3.6-tk \
        python3-pip \
        && \
    # wget -O ~/get-pip.py \
    #     https://bootstrap.pypa.io/get-pip.py && \
    # python3.6 ~/get-pip.py && \
    ln -s /usr/bin/python3.6 /usr/local/bin/python3 && \
    ln -s /usr/bin/python3.6 /usr/local/bin/python && \

    $PIP_INSTALL \
        setuptools \
        && \
    $PIP_INSTALL \
        numpy matplotlib pillow wordcloud imageio jieba snownlp itchat \
        && \

# ==================================================================
# config & cleanup
# ------------------------------------------------------------------

    ldconfig && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/* \
    && \
# ==================================================================
# zsh
# ------------------------------------------------------------------
    $GIT_CLONE https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh \
    && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
    && chsh -s /bin/zsh \
    && sed -i 's/^plugins.*/plugins=(git docker)/' ~/.zshrc \
    && \
    rm -rf /tmp/* && \
# ==================================================================
# board
# ------------------------------------------------------------------   
    #tsinghua pip mirror
    $PIP_INSTALL -i https://pypi.tuna.tsinghua.edu.cn/simple pip -U \
    && \
    python -m pip config set global.index-url https://mirrors.aliyun.com/pypi/simple/ && \ 
    python -m pip config set install.trusted-host mirrors.aliyun.com \
    && \
        rm -rf /var/lib/apt/lists/* \
           /etc/apt/sources.list.d/cuda.list \
           /etc/apt/sources.list.d/nvidia-ml.list && \
    # apt source
    rm -rf /etc/apt/sources.lists && \
    touch /etc/apt/sources.lists    && \
    echo deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse > /etc/apt/sources.list && \
    echo deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse >> /etc/apt/sources.list && \
    echo deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse >> /etc/apt/sources.list && \
    echo deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse >> /etc/apt/sources.list && \
    echo deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse >> /etc/apt/sources.list && \
    apt-get update && \
# ==================================================================
# config & cleanup 2
# ------------------------------------------------------------------
    ldconfig && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/*
