#!/bin/bash
SCRIPT_HOME=$(pwd)

sudo pacman -S --needed xfce4-docklike-plugin xfce4-panel-profiles xcursor-themes git go bluez blueman pulseaudio-bluetooth pulseaudio-alsa &&
sudo systemctl enable --now bluetooth

cd ~

git clone https://aur.archlinux.org/yay.git &&
cd yay &&
makepkg &&
makepkg --install --needed &&
cd .. &&
rm -rf yay

yay --save --answerdiff None --answerclean None --removemake
yay -S --needed brave-bin numix-circle-icon-theme-git

xfce4-panel-profiles load $SCRIPT_HOME/panel-profile.tar.bz2

cp -fr $SCRIPT_HOME/config/* ~/.config
cp -fr $SCRIPT_HOME/local/* ~/.local
xfconf-query -c xfwm4 -p /general/theme -s "Adwaita-dark"
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
gsettings set org.gnome.desktop.interface icon-theme "Numix-Circle"
gsettings set org.gnome.desktop.interface cursor-theme "elementary"

xfconf-query -c xfce4-panel -p /plugins/plugin-11/button-icon -s "$HOME/.local/share/xfce4/start.png"
xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/show-panel-label -s 0
xfce4-panel -r
