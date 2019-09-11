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


# oh my zsh!
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cat >> ~/.zshrc << EOF
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    source /etc/profile.d/vte.sh
fi
EOF
