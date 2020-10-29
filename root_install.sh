#!/bin/bash
echo -e "${w}    _             _       _     _                    ${h}"
echo -e "${g}   / \   _ __ ___| |__   | |   (_)_ __  _   ___  _   ${h}"
echo -e "${b}  / _ \ | '__/ __| '_ \  | |   | | '_ \| | | \ \/ /  ${h}"
echo -e "${y} / ___ \| | | (__| | | | | |___| | | | | |_| |>  <   ${h}"
echo -e "${r}/_/   \_\_|  \___|_| |_| |_____|_|_| |_|\__,_/_/\_\  ${h}"


rm -rf /etc/locale.gen
cp ./locale.gen /etc/
locale-gen
rm -rf /etc/pacman.d/mirrorlist
cp ./mirrorlist /etc/pacman.d/
echo ".....................................OK"
pacstrap /mnt base linux linux-firmware base-devel vi vim networkmanager git
echo ".....................................OK"
genfstab -U -p /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab
echo ".....................................OK"
cd
cp ArchInstall -rf /mnt
arch-chroot /mnt
