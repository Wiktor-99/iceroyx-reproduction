FROM ubuntu:24.04

RUN --mount=type=bind,readonly,source=./gcc-15,target=/gcc-15 \
    mkdir -p /usr/local/gcc-15.1.0/ && \
    tar -xzvf /gcc-15/gcc-15.1.0-amd64-strip.tar.gz  -C /

RUN apt update && \
    apt install -y --no-install-recommends vim build-essential cmake git libacl1-dev ca-certificates && \
    update-alternatives --install /usr/bin/g++ g++ /usr/local/gcc-15.1.0/bin/g++-15.1.0 100 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/local/gcc-15.1.0/bin/gcc-15.1.0 100 && \
    update-alternatives --set g++ /usr/local/gcc-15.1.0/bin/g++-15.1.0 && \
    update-alternatives --set gcc /usr/local/gcc-15.1.0/bin/gcc-15.1.0 && \
    cp /usr/local/gcc-15.1.0/lib64/* /lib/x86_64-linux-gnu/ && \
    apt clean && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
COPY src /workspace/src

RUN cd /workspace/src && \
    git clone https://github.com/eclipse-iceoryx/iceoryx.git && \
    cd iceoryx && \
    git checkout v2.0.6 && \
    cmake -B build -Hiceoryx_meta && \
    cmake --build build -j $(nproc) && \
    cmake --build build --target install


RUN cmake -B build -S src/app && \
    cmake --build build