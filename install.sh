#!/bin/bash
echo -e "${w}    _             _       _     _                    ${h}"
echo -e "${g}   / \   _ __ ___| |__   | |   (_)_ __  _   ___  _   ${h}"
echo -e "${b}  / _ \ | '__/ __| '_ \  | |   | | '_ \| | | \ \/ /  ${h}"
echo -e "${y} / ___ \| | | (__| | | | | |___| | | | | |_| |>  <   ${h}"
echo -e "${r}/_/   \_\_|  \___|_| |_| |_____|_|_| |_|\__,_/_/\_\  ${h}"



read -r -p "现在开始切换国内源吗 qie huan dao guo nei yuan? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
		echo "Yes"
        rm -rf /etc/pacman.d/mirrorlist
        cp ./mirrorlist /etc/pacman.d/
        echo "mirrorlist yi qie huan dao zhong guo"
		;;

    [nN][oO]|[nN])
		echo "No"
       	;;

    *)
		echo "Invalid input..."
		exit 1
		;;
esac



read -r -p "现在开始更新系统吗 gen xin xi tong? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
		echo "Yes"
        pacstrap /mnt base linux linux-firmware base-devel vi vim networkmanager git
        echo "系统已经更新 xi tong yi gen xin"
		;;

    [nN][oO]|[nN])
		echo "No"
       	;;

    *)
		echo "Invalid input..."
		exit 1
		;;
esac

read -r -p "现在开始挂载文件 gua zai wen jian? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
		echo "Yes"
        genfstab -U -p /mnt >> /mnt/etc/fstab
        cat /mnt/etc/fstab
        echo "系统已经挂载 xi tong yi gua zai wan cheng"
		;;

    [nN][oO]|[nN])
		echo "No"
       	;;

    *)
		echo "Invalid input..."
		exit 1
		;;
esac

read -r -p "切换到硬盘 qie huan dao yin pan? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
		echo "Yes jin ru yin pan cheng gong"
        arch-chroot /mnt
        echo "进入硬盘成功"
	
		;;

    [nN][oO]|[nN])
		echo "No"
       	;;

    *)
		echo "Invalid input..."
		exit 1
		;;
esac

