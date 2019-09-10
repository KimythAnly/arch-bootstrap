#! /bin/zsh -e

export HOSTNAME=localhost
export USER=anly
export PASS= 
export TIMEZONE=Asia/Taipei
export ROOT_PART=/dev/sda3
export DM=x #gdm x 

# locale
sed -i 's/^#\(en_US\|zh_TW\)\(\.UTF-8\)/\1\2/g' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# timezone and time sync
ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
hwclock --systohc
systemctl enable systemd-timesyncd

# hostname
echo $HOSTNAME > /etc/hostname
sed -i "8i 127.0.1.1\t$HOSTNAME.localdomain\t$HOSTNAME" /etc/hosts

# startup daemon
systemctl enable fstrim.timer # only need if using SSD
systemctl enable NetworkManager

# boot loader
mkinitcpio -p linux
pacman --noconfirm -Sy grub os-prober efibootmgr
os-prober
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub
grub-mkconfig -o /boot/grub/grub.cfg
sed -i 's/(\tlinux.*)quiet/\1/' /boot/grub/grub.cfg


systemctl enable cups-browsed # for printer
systemctl enable dhcpcd

# sudo
sed -i 's/# \(%wheel ALL=(ALL) ALL\)/\1/' /etc/sudoers

useradd -mG wheel,storage,power,video,audio $USER
echo "$USER:$PASS" | chpasswd
# disable root login
# passwd -l root


echo "gnome-session" > /home/${USER}/.xinitrc
cat >> /home/${USER}/.bash_profile << EOF
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -le 3 ]]; then
    exec startx
fi
EOF

exit
