bash yay.sh

# Chewing ime
sudo cat > /etc/profile.d/ibus.sh << EOF
GTK_IM_MODULE=ibus
QT_IM_MODULE=ibus
XMODIFIERS="@im=ibus"
EOF

# Google Chrome
cd ~/Downloads
git https://aur.archlinux.org/google-chrome.git
cd google-chrome
makepkg -si

