#!/bin/bash
echo -e "${w}    _             _       _     _                    ${h}"
echo -e "${g}   / \   _ __ ___| |__   | |   (_)_ __  _   ___  _   ${h}"
echo -e "${b}  / _ \ | '__/ __| '_ \  | |   | | '_ \| | | \ \/ /  ${h}"
echo -e "${y} / ___ \| | | (__| | | | | |___| | | | | |_| |>  <   ${h}"
echo -e "${r}/_/   \_\_|  \___|_| |_| |_____|_|_| |_|\__,_/_/\_\  ${h}"



read -r -p "现在开始切换国内源吗? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
		echo "Yes"
        rm -rf /etc/pacman.d/mirrorlist
        cp ./mirrorlist /etc/pacman.d/mirrorlist
        echo "mirrorlist文件已替换"
		;;

    [nN][oO]|[nN])
		echo "No"
       	;;

    *)
		echo "Invalid input..."
		exit 1
		;;
esac



read -r -p "现在开始更新系统吗? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
		echo "Yes"
        pacstrap /mnt base linux linux-firmware base-devel vi vim networkmanager git
        echo "系统已经更新"
		;;

    [nN][oO]|[nN])
		echo "No"
       	;;

    *)
		echo "Invalid input..."
		exit 1
		;;
esac

read -r -p "现在开始挂载文件? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
		echo "Yes"
        genfstab -U -p /mnt >> /mnt/etc/fstab
        cat /mnt/etc/fstab
        echo "系统已经挂载"
		;;

    [nN][oO]|[nN])
		echo "No"
       	;;

    *)
		echo "Invalid input..."
		exit 1
		;;
esac

read -r -p "切换到硬盘? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
		echo "Yes"
        arch-chroot /mnt
        echo "进入硬盘成功"
	git clone https://github.com/zhaocai-ally/archlinuxinstall.git
	sh ./install.sh
		;;

    [nN][oO]|[nN])
		echo "No"
       	;;

    *)
		echo "Invalid input..."
		exit 1
		;;
esac

read -r -p "创建时间区域为上海? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
		echo "Yes"
        ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
        hwclock --systohc
        echo "区域已创建"
		;;

    [nN][oO]|[nN])
		echo "No"
       	;;

    *)
		echo "Invalid input..."
		exit 1
		;;
esac

read -r -p "更新系统语言? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
		echo "Yes"
        rm -rf vim /etc/locale.gen
        cp ./locale.gen /etc/locale.gen
        locale-gen
        echo "语言设置完成"
		;;

    [nN][oO]|[nN])
		echo "No"
       	;;

    *)
		echo "Invalid input..."
		exit 1
		;;
esac

read -r -p "进入本地设置? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
		echo "Yes"
        cp ./locale.conf /etc/locale.conf
        cp ./hostname /etc/hostname
        rm -rf /etc/hosts
        cp ./hosts /etc/hosts
        echo "本地设置完成"
		;;

    [nN][oO]|[nN])
		echo "No"
       	;;

    *)
		echo "Invalid input..."
		exit 1
		;;
esac

read -r -p "设置root密码? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
		echo "Yes"
        passwd
        echo "密码已设定"
		;;

    [nN][oO]|[nN])
		echo "No"
       	;;

    *)
		echo "Invalid input..."
		exit 1
		;;
esac

read -r -p "安装软件? [Y/n] " input

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
        echo "软件安装完毕"
		;;

    [nN][oO]|[nN])
		echo "No"
       	;;

    *)
		echo "Invalid input..."
		exit 1
		;;
esac

read -r -p "安装grub系统引导? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
		echo "Yes"
        grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Arch
        echo "grub已安装"
		;;

    [nN][oO]|[nN])
		echo "No"
       	;;

    *)
		echo "Invalid input..."
		exit 1
		;;
esac

read -r -p "创建grub系统引导? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
		echo "Yes"
        grub-mkconfig -o /boot/grub/grub.cfg
        echo "grub引导创建完成"
		;;

    [nN][oO]|[nN])
		echo "No"
       	;;

    *)
		echo "Invalid input..."
		exit 1
		;;
esac

read -r -p "配置桌面环境? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
		echo "Yes"
        pacman -S xf86-video-vesa
        pacman -S xf86-video-intel
        pacman -S xorg
        pacman -S xf86-input-synaptics
        pacman -S ttf-dejavu wqy-microhei
        echo "桌面环境配置完成"
		;;

    [nN][oO]|[nN])
		echo "No"
       	;;

    *)
		echo "Invalid input..."
		exit 1
		;;
esac

read -r -p "添加普通用户? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
		echo "Yes"
        useradd -m -g users -G wheel -s /bin/bash zhaocai
        echo "用户已添加"
		;;

    [nN][oO]|[nN])
		echo "No"
       	;;

    *)
		echo "Invalid input..."
		exit 1
		;;
esac

read -r -p "设置用户权限? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
		echo "Yes"
		echo “在文件中找到 %wheel ALL=（ALL）这一行去掉#”
        visudo
        echo "已添加sudo权限"
		;;

    [nN][oO]|[nN])
		echo "No"
       	;;

    *)
		echo "Invalid input..."
		exit 1
		;;
esac

read -r -p "设置普通用户密码? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
		echo "Yes"
        passwd zhaocai
        echo "密码设置成功"
		;;

    [nN][oO]|[nN])
		echo "No"
       	;;

    *)
		echo "Invalid input..."
		exit 1
		;;
esac

read -r -p "安装kde桌面? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
		echo "Yes"
        pacman -S alsa-utils pulseaudio pulseaudio-alsa
        pacman -S plasma kde-applications
        systemctl enable sddm
        systemctl enable NetworkManager
        echo "用户已添加"
		;;

    [nN][oO]|[nN])
		echo "No"
       	;;

    *)
		echo "Invalid input..."
		exit 1
		;;
esac

read -r -p "进入kde桌面? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
		echo "Yes"
        systemctl start NetworkManager
        systemctl start sddm
        echo "完成"
		;;

    [nN][oO]|[nN])
		echo "No"
       	;;

    *)
		echo "Invalid input..."
		exit 1
		;;
esac
