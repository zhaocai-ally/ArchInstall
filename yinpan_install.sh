#!/bin/bash
echo -e "${w}    _             _       _     _                    ${h}"
echo -e "${g}   / \   _ __ ___| |__   | |   (_)_ __  _   ___  _   ${h}"
echo -e "${b}  / _ \ | '__/ __| '_ \  | |   | | '_ \| | | \ \/ /  ${h}"
echo -e "${y} / ___ \| | | (__| | | | | |___| | | | | |_| |>  <   ${h}"
echo -e "${r}/_/   \_\_|  \___|_| |_| |_____|_|_| |_|\__,_/_/\_\  ${h}"





read -r -p "创建时间区域为上海 gen gai shi qu wei shanghai? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
		echo "Yes"
        ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
        hwclock --systohc
        echo "区域已创建 qu yu yi chuang jian"
		;;

    [nN][oO]|[nN])
		echo "No"
       	;;

    *)
		echo "Invalid input..."
		exit 1
		;;
esac

read -r -p "更新系统语言 gen xin xi tong yu yan? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
		echo "Yes"
        rm -rf /etc/locale.gen
        cp ./locale.gen /etc/
        locale-gen
        echo "语言设置完成 yu yan she zhi wan cheng"
		;;

    [nN][oO]|[nN])
		echo "No"
       	;;

    *)
		echo "Invalid input..."
		exit 1
		;;
esac

read -r -p "进入本地设置 ben di she zhi ? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
		echo "Yes"
        cp ./locale.conf /etc/
        cp ./hostname /etc/
        rm -rf /etc/hosts
        cp ./hosts /etc/
	rm -rf /etc/pacman.conf
	cp ./pacman.conf /etc/
        echo "本地设置完成 ben di she zhi wan cheng"
		;;

    [nN][oO]|[nN])
		echo "No"
       	;;

    *)
		echo "Invalid input..."
		exit 1
		;;
esac

read -r -p "设置root密码 root mi ma she zhi? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
		echo "Yes"
        passwd
        echo "密码已设定 mi ma yi she zhi wan cheng"
		;;

    [nN][oO]|[nN])
		echo "No"
       	;;

    *)
		echo "Invalid input..."
		exit 1
		;;
esac

read -r -p "安装软件 an zhuang ruan jian ? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
		echo "Yes"
        pacman -S intel-ucode
        pacman -S grub efibootmgr dosfstools ntfs-3g os-prober
        pacman -Syu haveged
        systemctl start haveged
        systemctl enable haveged
        rm -fr /etc/pacman.d/gnupg
        pacman-key --init
        pacman-key --populate archlinux
        pacman -Syy archlinuxcn-keyring
	pacman-key --populate archlinuxcn
        echo "软件安装完毕 ruan jian an zhuang wan cheng"
		;;

    [nN][oO]|[nN])
		echo "No"
       	;;

    *)
		echo "Invalid input..."
		exit 1
		;;
esac

read -r -p "安装grub系统引导 an zhuang grub xi tong yin dao? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
		echo "Yes"
        grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Arch
        echo "grub已安装 grub yi an zhuang wan cheng"
		;;

    [nN][oO]|[nN])
		echo "No"
       	;;

    *)
		echo "Invalid input..."
		exit 1
		;;
esac

read -r -p "创建grub系统引导 chuang jian grub yin dao? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
		echo "Yes"
        grub-mkconfig -o /boot/grub/grub.cfg
        echo "grub引导创建完成 grub yin dao chuang jian wan cheng"
		;;

    [nN][oO]|[nN])
		echo "No"
       	;;

    *)
		echo "Invalid input..."
		exit 1
		;;
esac

read -r -p "配置桌面环境 pei zhi zhuo mian huan jin? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
		echo "Yes"
        pacman -S xf86-video-vesa
        pacman -S xf86-video-intel
        pacman -S xorg
        pacman -S xf86-input-synaptics
        pacman -S ttf-dejavu wqy-microhei
        echo "桌面环境配置完成 zhuo mian huan jin yi pei zhi wan cheng"
		;;

    [nN][oO]|[nN])
		echo "No"
       	;;

    *)
		echo "Invalid input..."
		exit 1
		;;
esac

read -r -p "添加普通用户 tian jia pu tong yong hu? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
		echo "Yes"
        useradd -m -g users -G wheel -s /bin/bash zhaocai
        echo "用户已添加 yong hu yi tian jia "
		;;

    [nN][oO]|[nN])
		echo "No"
       	;;

    *)
		echo "Invalid input..."
		exit 1
		;;
esac

read -r -p "设置用户权限 she zhi yong hu quan xian? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
		echo "Yes"
		echo “在文件中找到 zhao dao %wheel ALL=（ALL）zhe yi hang qu diao这一行去掉#”
        visudo
        echo "已添加sudo权限 yi tian jia sudo quan xian "
		;;

    [nN][oO]|[nN])
		echo "No"
       	;;

    *)
		echo "Invalid input..."
		exit 1
		;;
esac

read -r -p "设置普通用户密码 she zhi pu tong yong hu mi ma ? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
		echo "Yes"
        passwd zhaocai
        echo "密码设置成功 mi ma she zhi cheng gong"
		;;

    [nN][oO]|[nN])
		echo "No"
       	;;

    *)
		echo "Invalid input..."
		exit 1
		;;
esac

read -r -p "安装kde桌面 an zhuang kde zhuo mian? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
		echo "Yes"
        pacman -S alsa-utils pulseaudio pulseaudio-alsa
        pacman -S plasma kde-applications
        systemctl enable sddm
        systemctl enable NetworkManager
        echo "zhuo mian an zhuang wan cheng"
		;;

    [nN][oO]|[nN])
		echo "No"
       	;;

    *)
		echo "Invalid input..."
		exit 1
		;;
esac

read -r -p "进入kde桌面 jin ru zhuo mian huan jin? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
		echo "Yes"
        systemctl start NetworkManager
        echo "shu ru exit tui chu dao root shu ru reboot chong qi"
		;;

    [nN][oO]|[nN])
		echo "No"
       	;;

    *)
		echo "Invalid input..."
		exit 1
		;;
esac
