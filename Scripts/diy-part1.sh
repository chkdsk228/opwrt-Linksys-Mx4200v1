#!/bin/bash

# 添加VIKINGYFY的软件源
echo "src-git vikingyfy https://github.com/VIKINGYFY/packages.git" >> feeds.conf.default

# 更新并安装 feeds
./scripts/feeds update -a
./scripts/feeds install -a

# 设置默认主题为VIKINGYFY的主题
echo "CONFIG_PACKAGE_luci-theme-argon=y" >> .config
echo "CONFIG_PACKAGE_luci-app-argon-config=y" >> .config

# 设置默认IP地址（VIKINGYFY设置）
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

# 设置默认主机名
sed -i 's/OpenWrt/OWRT/g' package/base-files/files/bin/config_generate
