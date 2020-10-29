echo -e "${w}    _             _       _     _                    ${h}"
echo -e "${g}   / \   _ __ ___| |__   | |   (_)_ __  _   ___  _   ${h}"
echo -e "${b}  / _ \ | '__/ __| '_ \  | |   | | '_ \| | | \ \/ /  ${h}"
echo -e "${y} / ___ \| | | (__| | | | | |___| | | | | |_| |>  <   ${h}"
echo -e "${r}/_/   \_\_|  \___|_| |_| |_____|_|_| |_|\__,_/_/\_\  ${h}"


ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc
echo ".....................................OK"

rm -rf /etc/locale.gen
cp ./locale.gen /etc/
locale-gen
echo ".....................................OK"

cp ./locale.conf /etc/
cp ./hostname /etc/
rm -rf /etc/hosts
cp ./hosts /etc/
rm -rf /etc/pacman.conf
cp ./pacman.conf /etc/
echo ".....................................OK"
passwd
echo "qing shu ru mi ma 请输入密码并确认密码："
echo ".....................................OK"

pacman -Sy intel-ucode
pacman -S amd-ucode
pacman -Sy grub efibootmgr dosfstools ntfs-3g os-prober
pacman -Syu haveged
systemctl start haveged
systemctl enable haveged
rm -fr /etc/pacman.d/gnupg
pacman-key --init
pacman-key --populate archlinux
pacman -Syy archlinuxcn-keyring
pacman-key --populate archlinuxcn
echo ".....................................OK"
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Arch
echo ".....................................OK"
grub-mkconfig -o /boot/grub/grub.cfg
echo ".....................................OK"
pacman -S xf86-video-vesa
pacman -S xf86-video-intel
pacman -S xorg
pacman -S xf86-input-synaptics
pacman -S ttf-dejavu wqy-microhei
echo ".....................................OK"
useradd -m -g users -G wheel -s /bin/bash arch
echo ".....................................OK"
passwd arch
echo "qing shu ru mi ma 请输入密码并确认密码："
echo ".....................................OK"
pacman -S alsa-utils pulseaudio pulseaudio-alsa yay google-chrom
yay --aururl "https://aur.tuna.tsinghua.edu.cn" --save
pacman -S plasma kde-applications plasma-wayland-session
systemctl enable sddm
systemctl enable NetworkManager
echo ".....................................OK"
systemctl start NetworkManager
echo ".....................................OK"

