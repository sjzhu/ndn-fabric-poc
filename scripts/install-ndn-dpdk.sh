#!/bin/bash

# install ndn-dpdk
git clone https://github.com/usnistgov/ndn-dpdk.git ~/ndn-dpdk
cd ~/ndn-dpdk
./docs/ndndpdk-depends.sh -y
corepack pnpm install
NDNDPDK_MK_RELEASE=1 make
sudo make install

# enable hugepages
sudo dpdk-hugepages.py --pagesize 1G --setup 10G
dpdk-hugepages.py --show

# start ndn-dpdk service
sudo ndndpdk-ctrl systemd start