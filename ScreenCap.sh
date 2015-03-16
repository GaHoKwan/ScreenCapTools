#!/bin/bash
thisDir=`pwd`

function main(){
clear 
echo -e "\t\t\t\t     截图工具"
echo -e "\t\t\t\t\t\t\t     --作者：嘉豪仔_Kwan"
echo -e "\t输入命令号码 :\n"
echo -e "\t\t1. 截图"
echo -e "\t\t2. 截图(推送binary到system，备用选项）"
echo -e "\t\t3. 拉取截图"
echo -e "\t\t4. 清理缓存"
echo -ne "\n选择:"
read inp
case $inp in
	1)
		echo ">>> 正在获取截图..."
		adb shell mkdir -p /data/local/tmp/Screenshot
		adb shell 'screencap -p "/data/local/tmp/Screenshot/`date`.png"'
		echo ">>> 操作完成..."
		sleep 1
		main
	;;
	2)
		adb push screencap /data/local/tmp
		adb shell chmod 755 /data/local/tmp/screencap
		adb shell mkdir -p /data/local/tmp/Screenshot
		echo ">>> 正在获取截图..."
		adb shell '/data/local/tmp/screencap -p "/data/local/tmp/Screenshot/`date`.png"'
		echo ">>> 操作完成..."
		sleep 1
		main
	;;
	3)
		echo ">>> 正在拉取截图至$thisDir..."
		adb pull "/data/local/tmp/Screenshot/" $thisDir
		echo ">>> 操作完成..."
		sleep 2
		main
	;;
	4)
		echo ">>> 正在清理缓存文件..."
		adb shell rm -rf /data/local/tmp/Screenshot
		rm -rf $thisDir/*.png
		echo ">>> 操作完成..."
		sleep 2
		main
	;;
	*)
	main
	;;
esac
}
main
