#!/bin/bash
# Copyright (C) 2016 Nitrogen Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# The Unholy builder
ver_script=1.0

unholy_dir=unholy
unholy_build_dir=$unholy_dir-build

if ! [ -d ~/$unholy_build_dir ]; then
	echo -e "${bldred}No unholy-build directory, creating...${txtrst}"
	mkdir ~/$unholy_build_dir
fi

cpucores=$(cat /proc/cpuinfo | grep 'model name' | sed -e 's/.*: //' | wc -l)

#export USE_PREBUILT_CHROMIUM=1

configb=null
build_img=null
othermsg=""

# Colorize and add text parameters
red=$(tput setaf 1)			 #  red
grn=$(tput setaf 2)			 #  green
cya=$(tput setaf 6)			 #  cyan
txtbld=$(tput bold)			 # Bold
bldred=${txtbld}$(tput setaf 1) #  red
bldgrn=${txtbld}$(tput setaf 2) #  green
bldblu=${txtbld}$(tput setaf 4) #  blue
bldcya=${txtbld}$(tput setaf 6) #  cyan
txtrst=$(tput sgr0)			 # Reset

function build_unholy {
	if [ $configb = "null" ]; then
		echo "Device is not set!"
		break
	fi
	repo_clone
	echo -e "${bldblu}Setting up environment ${txtrst}"
	. build/envsetup.sh
	clear
	echo -e "${bldblu}Starting compilation ${txtrst}"
	res1=$(date +%s.%N)
	lunch unholy_$configb-userdebug
	clear
	make otapackage -j$cpucores 2<&1 | tee builder.log
	res2=$(date +%s.%N)
	cd out/target/product/$configb
	FILE=$(ls *.zip | grep Unholy)
	if [ -f ./$FILE ]; then
		echo -e "${bldgrn}Copyng zip file...${txtrst}"
		cp $FILE ~/$unholy_build_dir/$FILE
	else
		echo -e "${bldred}Error copyng zip!${txtrst}"
	fi
	cd ~/$unholy_dir
	echo "${bldgrn}Total time elapsed: ${txtrst}${grn}$(echo "($res2 - $res1) / 60"|bc ) minutes ($(echo "$res2 - $res1"|bc ) seconds) ${txtrst}"
}

function build_images {
	if [ $configb = "null" ]; then
		echo "Device is not set!"
		break
	fi
	repo_clone
	. build/envsetup.sh
	if [ $build_img = "null" ]; then
		echo "Img file is not set!"
		break
	fi
	if [ $build_img = "boot" ]; then
		echo "Build boot.img/kernel..."
		res1=$(date +%s.%N)
		lunch unholy_$configb-userdebug
		make bootimage -j$cpucores 2<&1 | tee builder.log
		res2=$(date +%s.%N)
		echo "${bldgrn}Total time elapsed: ${txtrst}${grn}$(echo "($res2 - $res1) / 60"|bc ) minutes ($(echo "$res2 - $res1"|bc ) seconds) ${txtrst}"
		break
	fi
	if [ $build_img = "recovery" ]; then
		echo "Build recovery.img..."
		res1=$(date +%s.%N)
		lunch unholy_$configb-userdebug
		make recoveryimage -j$cpucores 2<&1 | tee builder.log
		res2=$(date +%s.%N)
		echo "${bldgrn}Total time elapsed: ${txtrst}${grn}$(echo "($res2 - $res1) / 60"|bc ) minutes ($(echo "$res2 - $res1"|bc ) seconds) ${txtrst}"
		break
	fi
	if [ $build_img = "system" ]; then
		echo "Build system.img..."
		res1=$(date +%s.%N)
		lunch unholy_$configb-userdebug
		make systemimage -j$cpucores 2<&1 | tee builder.log
		res2=$(date +%s.%N)
		echo "${bldgrn}Total time elapsed: ${txtrst}${grn}$(echo "($res2 - $res1) / 60"|bc ) minutes ($(echo "$res2 - $res1"|bc ) seconds) ${txtrst}"
		break
	fi
	if [ $build_img = "all" ]; then
		echo "Build all images..."
		res1=$(date +%s.%N)
		lunch unholy_$configb-userdebug
		make -j$cpucores 2<&1 | tee builder.log
		res2=$(date +%s.%N)
		echo "${bldgrn}Total time elapsed: ${txtrst}${grn}$(echo "($res2 - $res1) / 60"|bc ) minutes ($(echo "$res2 - $res1"|bc ) seconds) ${txtrst}"
		break
	fi
}

function repo_device_sync {
	# Shamu
	if [ $configb = "shamu" ]; then
		if [ -d device/motorola/shamu ]; then
			cd device/motorola/shamu
			git pull -f
			cd ~/$unholy_dir
		else
			repo_clone
		fi

		if [ -d kernel/motorola/shamu ]; then
			cd kernel/motorola/shamu
			git pull -f
			cd ~/$unholy_dir
		else
			repo_clone
		fi

		if [ -d vendor/motorola/shamu ]; then
			cd vendor/motorola/shamu
			git pull -f
			cd ~/$unholy_dir
		else
			repo_clone
		fi
	fi
	# Angler
	if [ $configb = "angler" ]; then
		if [ -d device/huawei/angler ]; then
			cd device/huawei/angler
			git pull -f
			cd ~/$unholy_dir
		else
			repo_clone
		fi

		if [ -d kernel/huawei/angler ]; then
			cd kernel/huawei/angler
			git pull -f
			cd ~/$unholy_dir
		else
			repo_clone
		fi

		if [ -d vendor/huawei/angler ]; then
			cd vendor/huawei/angler
			git pull -f
			cd ~/$unholy_dir
		else
			repo_clone
		fi
	fi
	# Marlin
	if [ $configb = "marlin" ]; then
		if [ -d device/google/marlin ]; then
			cd device/google/marlin
			git pull -f
			cd ~/$unholy_dir
		else
			repo_clone
		fi

		if [ -d kernel/google/marlin ]; then
			cd kernel/google/marlin
			git pull -f
			cd ~/$unholy_dir
		else
			repo_clone
		fi

		if [ -d vendor/google/marlin ]; then
			cd vendor/google/marlin
			git pull -f
			cd ~/$unholy_dir
		else
			repo_clone
		fi
	fi

function repo_clone {
	if [ $configb = "shamu" ]; then
		if ! [ -d device/motorola/shamu ]; then
			echo -e "${bldred}N6: No device tree, downloading...${txtrst}"
			git clone https://github.com/unholydevs/device_motorola_shamu.git -b n7 device/motorola/shamu
		fi
		if ! [ -d kernel/motorola/shamu ]; then
			echo -e "${bldred}N6: No kernel sources, downloading...${txtrst}"
			git clone https://github.com/unholydevs/kernel_motorola_shamu.git -b n7 kernel/motorola/shamu
		fi
		if ! [ -d vendor/motorola/shamu ]; then
			echo -e "${bldred}N6: No vendor, downloading...${txtrst}"
			git clone https://github.com/unholydevs/vendor_motorola.git -b n7 vendor/motorola
		fi
	fi
	if [ $configb = "angler" ]; then
		if ! [ -d device/huawei/angler ]; then
			echo -e "${bldred}N6P: No device tree, downloading...${txtrst}"
			git clone https://github.com/unholydevs/device_huawei_angler.git -b n7 device/huawei/angler
		fi
		if ! [ -d kernel/huawei/angler ]; then
			echo -e "${bldred}N6P: No kernel sources, downloading...${txtrst}"
			git clone https://github.com/unholydevs/kernel_huawei_angler.git -b n7 kernel/huawei/angler
		fi
		if ! [ -d vendor/huawei/angler ]; then
			echo -e "${bldred}N6P: No vendor, downloading...${txtrst}"
			git clone https://github.com/unholydevs/vendor_huawei.git -b n7 vendor/huawei
		fi
	fi
	if [ $configb = "marlin" ]; then
		if ! [ -d device/google/marlin ]; then
			echo -e "${bldred}Marlin: No device tree, downloading...${txtrst}"
			git clone https://github.com/unholydevs/device_google_marlin.git -b n7 device/google/marlin
		fi
		if ! [ -d kernel/google/marlin ]; then
			echo -e "${bldred}Marlin: No kernel sources, downloading...${txtrst}"
			git clone https://github.com/unholydevs/kernel_google_marlin.git -b n7 kernel/google/marlin
		fi
		if ! [ -d vendor/google/marlin ]; then
			echo -e "${bldred}Marlin: No vendor, downloading...${txtrst}"
			git clone https://github.com/unholydevs/vendor_google.git -b n7 vendor/google
		fi
	fi

function sync_unholy {
	if [ $sync_repo_devices = true ]; then
		repo_clone
		repo_device_sync
	fi
	repo sync --force-sync -j$cpucores
}

function setccache {
	while read -p "Use ccache for build (y/n)?
:> " cchoice
    do
    case "$cchoice" in
	y )
		export USE_CCACHE=1
		export CCACHE_DIR=~/.ccache/unholy
		prebuilts/misc/linux-x86/ccache/ccache -M 50G
		if ! [ -d ~/.ccache/$unholy_dir ]; then
			echo -e "${bldred}No ccache directory, creating...${txtrst}"
			mkdir ~/.ccache
			mkdir ~/.ccache/$unholy_dir
		fi
		ccachetrue="yes"
		break
		;;
	n )
		
		ccachetrue="no"
		break
		;;
	* )
		echo "Invalid! Try again!"
		clear
		;;
	esac
	done
}

function set_device {
while read -p "${grn}Please choose your device:${txtrst}
 1. shamu (Google Nexus 6)
 2. angler (Nexus 6P)
 3. marlin (Pixel XL)
 4. Abort
:> " cchoice
do
case "$cchoice" in
	1 )
		configb=shamu
		break
		;;
	2 )
		configb=angler
		break
		;;
	3 )
		configb=marlin
		break
		;;
	4 )
		break
		;;
	* )
		echo "Invalid, try again!"
		clear
		;;
esac
done
}

function mainmenu {
	setccache
	clear
	set_device
	clear
	if [ $configb = "null" ]; then
		device_text="Device is not set!"
	else
		device_text="Device: $configb"
	fi
	if [ $ccachetrue = "yes" ]; then
		ccachetext="Use cchache for build: yes"
	else
		ccachetext="Use cchache for build: no"
	fi
while read -p "${bldcya}unholy OS 2.0 builder script v. $ver_script ${txtrst}
  $device_text
  $ccachetext
  Messages:
  $othermsg
  
${grn}Please choose your option:${txtrst}
  1. Clean build files
  2. Build rom to zip (ota package)
  3. Build boot.img
  4. Build recovery.img
  5. Build system.img
  6. Build all (all img files)
  7. Sync sources (force-sync)
  8. Sync sources and device tree (force-sync)
  9. Reset sources
  10. Install soft
  11. Change device
  12. Exit
:> " cchoice
do
case "$cchoice" in
	1 )
		make clean
		othermsg="All the compiled files have been deleted."
		clear
		;;
	2 )
		build_unholy
		break
		;;
	3 )
		build_img="boot"
		build_images
		break
		;;
	4 )
		build_img="recovery"
		build_images
		break
		;;
	5 )
		build_img="system"
		build_images
		break
		;;
	6 )
		build_img="all"
		build_images
		break
		;;
	7 )
		sync_repo_devices=false
		sync_unholy
		othermsg="Sources have been successfully synchronized!"
		clear
		;;
	8 )
		sync_repo_devices=true
		sync_unholy
		othermsg="Sources have been successfully synchronized!"
		clear
		;;
	9 )
		repo forall -c git reset --hard
		othermsg="Sources have been returned to its original state."
		clear
		;;
	10 )
		sudo apt-get install bison build-essential curl flex lib32ncurses5-dev lib32readline-gplv2-dev lib32z1-dev libesd0-dev libncurses5-dev libsdl1.2-dev libwxgtk2.8-dev libxml2 libxml2-utils lzop openjdk-7-jdk openjdk-7-jre pngcrush schedtool squashfs-tools xsltproc zip zlib1g-dev git-core make phablet-tools gperf
		othermsg="Soft installed"
		clear
		;;
	11 )
		set_device
		device_text="Device: $configb"
		othermsg="The device is changed to $configb."
		clear
		;;
	12 )
		break
		;;
	* )
		echo "Invalid! Try again!"
		clear
		;;
esac
done
}

mainmenu