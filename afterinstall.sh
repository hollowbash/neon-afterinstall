#!/bin/bash
export COLOR="\e[32m"

echo -e "${COLOR}Remove packages"; tput sgr0
sudo apt -y purge firefox* kwrite vim
sudo apt -y autoremove

echo -e "${COLOR}Upgrade system"; tput sgr0
sudo apt -y update
sudo apt -y dist-upgrade

echo -e "${COLOR}Download and install Google Chrome"; tput sgr0
wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt -y install -f

echo -e "${COLOR}Download and install Telegram"; tput sgr0
wget -c https://github.com/telegramdesktop/tdesktop/releases/download/v2.3.2/tsetup.2.3.2.tar.xz
tar -xf tsetup*
mkdir -p ~/.local/share/TelegramDesktop/
cp -R Telegram ~/.local/share/TelegramDesktop/
timeout 20s ~/.local/share/TelegramDesktop/Telegram/Telegram

echo -e "${COLOR}Download and install Mellow Player"; tput sgr0
wget -c http://download.opensuse.org/repositories/home:/ColinDuquesnoy/xUbuntu_20.04/amd64/mellowplayer_3.6.5-0_amd64.deb
sudo dpkg -i mellowplayer*.deb
sudo apt -y install -f

echo -e "${COLOR}Download and install GitHub Desktop"; tput sgr0
wget -c https://github.com/shiftkey/desktop/releases/download/release-2.5.4-linux1/GitHubDesktop-linux-2.5.4-linux1.deb
sudo dpkg -i GitHubDesktop*.deb
sudo apt -y install -f

echo -e "${COLOR}Add PPA's"; tput sgr0
sudo add-apt-repository -y ppa:varlesh-l/focal
sudo add-apt-repository -y ppa:papirus/papirus
sudo add-apt-repository -y ppa:papirus/hardcode-tray
sudo apt -y update

echo -e "${COLOR}Install packages"; tput sgr0
sudo apt -y install git latte-dock lm-sensors p7zip-full qbittorrent kate muon qapt-deb-installer apt-xapian-index qt5-style-kvantum papirus-icon-theme materia-kde materia-gtk-theme hardcode-tray plasma-applet-weather-widget plasma-applet-thermal-monitor plasma-widget-playbar2 sox libqt5quick5 yakuake qml-module-qtquick-localstorage

echo -e "${COLOR}Install dev tools"; tput sgr0
sudo apt -y install dput dh-make devscripts gnome-keyring curl gimp inkscape kcolorchooser imagemagick
sudo apt -y purge nodejs npm
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt -y install nodejs
sudo npm install -g npm svgo

echo -e "${COLOR}Download and install widgets"; tput sgr0
cd /tmp/neon-afterinstall/widgets
plasmapkg2 -i rss-indicator*.plasmoid
plasmapkg2 -i netspeed-widget*.plasmoid
plasmapkg2 -i eventcalendar*.plasmoid
plasmapkg2 -i minimalmenu*.plasmoid
plasmapkg2 -i commandoutput*.plasmoid
plasmapkg2 -i org.kde.plasma.calendar.wl.plasmoid
plasmapkg2 -i org.kde.plasma.digitalclock.wl.plasmoid

cat AUTHORS
sleep 5
cd /tmp

echo -e "${COLOR}Apply new icon theme"; tput sgr0
sed -i s/Theme=breeze/Theme=Papirus-Dark/g ~/.config/kdeglobals

echo -e "${COLOR}Clear system cache"; tput sgr0
rm -rf ~/.cache/plasm* ~/.cache/ico*
sudo apt -y clean

echo -e "${COLOR}Fix hardcode tray icons"; tput sgr0
sudo -E hardcode-tray -s 22 -ct RSVGConvert --theme Papirus-Dark -a

echo -e "${COLOR}Fix hardcode apps icons"; tput sgr0
wget https://raw.githubusercontent.com/Foggalong/hardcode-fixer/master/fix.sh
chmod +x fix.sh 
sudo bash fix.sh

echo -e "${COLOR}Fix StartupWMClass"; tput sgr0
wget https://raw.githubusercontent.com/bil-elmoussaoui/StartupWMClassFixer/master/fix
chmod +x fix
sudo bash fix
cd
sleep 3

kdialog --passivepopup "KDE Neon After Install Finished!" --icon "kde" 10
play /usr/share/sounds/freedesktop/stereo/complete.oga
