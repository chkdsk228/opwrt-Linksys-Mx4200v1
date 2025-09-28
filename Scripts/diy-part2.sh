#!/bin/bash

# 安装VIKINGYFY的核心软件包
git clone --depth=1 https://github.com/VIKINGYFY/packages.git package/vikingyfy

# 安装OpenClash
git clone --depth=1 --single-branch --branch dev https://github.com/vernesong/OpenClash.git package/openclash

# 安装Kucat主题
git clone --depth=1 --single-branch --branch js https://github.com/sirpdboy/luci-theme-kucat.git package/kucat

# 安装mwan3多WAN负载均衡
git clone --depth=1 https://github.com/openwrt/packages.git package/packages
ln -s package/packages/net/mwan3 package/mwan3
ln -s package/packages/net/luci-app-mwan3 package/luci-app-mwan3

# 其他实用软件包
git clone --depth=1 https://github.com/nikkinikki-org/OpenWrt-momo.git package/momo
git clone --depth=1 https://github.com/nikkinikki-org/OpenWrt-nikki.git package/nikki
git clone --depth=1 https://github.com/sirpdboy/luci-app-ddns-go.git package/ddns-go
git clone --depth=1 https://github.com/lwb1978/openwrt-gecoosac.git package/gecoosac
git clone --depth=1 https://github.com/sirpdboy/luci-app-netspeedtest.git package/netspeedtest
git clone --depth=1 https://github.com/sirpdboy/luci-app-partexp.git package/partexp
git clone --depth=1 https://github.com/FUjr/QModem.git package/qmodem
git clone --depth=1 https://github.com/lmq8267/luci-app-vnt.git package/vnt
