FROM ubuntu:bionic

RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yqq build-essential gcc-multilib  quilt \
                       libncurses5-dev zlib1g-dev gawk flex gettext libssl-dev \
                       ccache sudo git-core subversion wget unzip python vim && \
    apt-get clean && \
    useradd -m openwrt && \
    echo 'openwrt ALL=NOPASSWD: ALL' > /etc/sudoers.d/openwrt
USER openwrt
RUN cd /home/openwrt && \
    git clone --depth 1 --branch v18.06.0 https://git.openwrt.org/openwrt.git openwrt && \
    cd openwrt && \
    ./scripts/feeds update && \
    rm -rf tmp
WORKDIR /home/openwrt/openwrt
