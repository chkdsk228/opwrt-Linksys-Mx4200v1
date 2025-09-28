#!/bin/bash
#
# Copyright (C) 2021 ImmortalWrt
# <https://immortalwrt.org>
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

set -eo pipefail

export LC_ALL=C
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# 清理工作目录
clean_workspace() {
	find . -maxdepth 1 -type f \( -name "*.config" -o -name "*.diff" -o -name "*.log" -o -name "*.patch" \) -delete
	[ -d ./bin ] && rm -rf ./bin
	[ -d ./build_dir ] && rm -rf ./build_dir
	[ -d ./staging_dir ] && rm -rf ./staging_dir
	[ -d ./tmp ] && rm -rf ./tmp
	[ -d ./dl ] && rm -rf ./dl
	[ -d ./feeds ] && rm -rf ./feeds
	[ -f ./.config ] && rm -f ./.config
	[ -f ./.config.old ] && rm -f ./.config.old
}

# 基础配置
basic_config() {
	[ -f "$WRT_CONFIG" ] && cp -f "$WRT_CONFIG" .config || {
		echo "ERROR: 配置文件 $WRT_CONFIG 不存在!"
		exit 1
	}

	# 加载默认配置
	make defconfig
}

# 执行自定义脚本
run_custom_scripts() {
	local script_dir="./Scripts"
	
	if [ -d "$script_dir" ]; then
		echo "开始执行自定义脚本..."
		
		# 执行第一阶段脚本
		if [ -f "$script_dir/diy-part1.sh" ]; then
			echo "执行diy-part1.sh..."
			chmod +x "$script_dir/diy-part1.sh"
			"$script_dir/diy-part1.sh"
			echo "diy-part1.sh执行完成"
		fi
		
		# 执行第二阶段脚本
		if [ -f "$script_dir/diy-part2.sh" ]; then
			echo "执行diy-part2.sh..."
			chmod +x "$script_dir/diy-part2.sh"
			"$script_dir/diy-part2.sh"
			echo "diy-part2.sh执行完成"
		fi
		
		# 执行第三阶段脚本
		if [ -f "$script_dir/diy-part3.sh" ]; then
			echo "执行diy-part3.sh..."
			chmod +x "$script_dir/diy-part3.sh"
			"$script_dir/diy-part3.sh"
			echo "diy-part3.sh执行完成"
		fi
		
		echo "所有自定义脚本执行完成"
	else
		echo "未找到Scripts目录，跳过自定义脚本执行"
	fi
}

# 构建固件
build_firmware() {
	echo "开始构建固件..."
	make -j$(nproc) || make -j1 V=s
	
	# 检查构建结果
	if [ ! -d ./bin/targets ]; then
		echo "ERROR: 固件构建失败!"
		exit 1
	fi
	
	echo "固件构建完成"
}

# 主函数
main() {
	# 检查环境变量
	[ -z "$WRT_CONFIG" ] && {
		echo "ERROR: 请设置 WRT_CONFIG 环境变量!"
		exit 1
	}

	# 清理工作目录
	clean_workspace
	
	# 执行自定义脚本
	run_custom_scripts
	
	# 基础配置
	basic_config
	
	# 构建固件
	build_firmware
}

# 执行主函数
main "$@"
