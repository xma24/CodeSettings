From nvidia/cuda:11.7.1-devel-ubuntu22.04


# The following code is to solve GPG key problem; https://forums.developer.nvidia.com/t/notice-cuda-linux-repository-key-rotation/212771/5
RUN sh -c 'echo "APT { Get { AllowUnauthenticated \"1\"; }; };" > /etc/apt/apt.conf.d/99allow_unauth'

RUN apt -o Acquire::AllowInsecureRepositories=true -o Acquire::AllowDowngradeToInsecureRepositories=true update
RUN apt-get install -y curl wget

RUN apt-key del 7fa2af80
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-keyring_1.0-1_all.deb
RUN dpkg -i cuda-keyring_1.0-1_all.deb
RUN rm -f /etc/apt/sources.list.d/cuda.list /etc/apt/apt.conf.d/99allow_unauth cuda-keyring_1.0-1_all.deb
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A4B469963BF863CC F60F4B3D7FA2AF80

RUN apt-get update && apt-get upgrade -y
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl \
    ca-certificates \
    sudo \
    git \
    bzip2 \
    libx11-6 \
    python3-dev \
    wget \ 
    libxext6 \
    ffmpeg \
    libsm6 \
    graphviz \
    gcc \
    g++ \
    python3 \
    python3-pip \
    python3-venv \
    python-is-python3 \
    && rm -rf /var/lib/apt/lists/*


# docker build -t XXXXX .

# #!/bin/bash 
# # -e NVIDIA_VISIBLE_DEVICES=4,5,6,7
# docker run -itd --init --shm-size="300g" -p 5152:5152\
#     --name="YYYYY" --runtime=nvidia -e NVIDIA_VISIBLE_DEVICES=0,1,2,3 \
#     --ipc=host --user="$(id -u):$(id -g)" \
#     --volume="/home/xma24:/home/xma24" \
#     --volume="/data:/data" \
#     -v /etc/passwd:/etc/passwd:ro \
#     -v /etc/group:/etc/group:ro \
#     XXXXX python3


# docker exec -it YYYYY /bin/bash