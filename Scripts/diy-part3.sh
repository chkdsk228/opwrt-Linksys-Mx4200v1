#!/bin/bash

# 设置WiFi名称和密码（VIKINGYFY设置）
sed -i 's/ssid="OpenWrt"/ssid="OWRT"/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i 's/encryption="none"/encryption="psk2"/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i '/set wireless.default_radio\${devidx}.encryption=psk2/a\set wireless.default_radio\${devidx}.key=12345678' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 配置OpenClash
echo "CONFIG_PACKAGE_luci-app-openclash=y" >> .config
echo "CONFIG_PACKAGE_luci-app-openclash_INCLUDE_clash=y" >> .config
echo "CONFIG_PACKAGE_luci-app-openclash_INCLUDE_clash_tun=y" >> .config
echo "CONFIG_PACKAGE_luci-app-openclash_INCLUDE_clash_game=y" >> .config

# 配置mwan3
echo "CONFIG_PACKAGE_mwan3=y" >> .config
echo "CONFIG_PACKAGE_luci-app-mwan3=y" >> .config

# 配置系统语言
echo "CONFIG_LUCI_LANG_zh_Hans=y" >> .config

# 移除冲突的软件包
rm -rf package/feeds/luci/luci-theme-bootstrap
rm -rf package/feeds/luci/luci-theme-material
