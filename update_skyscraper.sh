#!/bin/bash
if ! command -v Skyscraper >> /dev/null; then
echo 'First time setup'
echo 'Installing required packages...'
pkg install x11-repo -y
pkg install git wget ffmpeg build-essential qt5-qtbase whiptail -y
fi
echo 'Creating and moving into source folder "skysource"...'
mkdir -p ./skysource && cd ./skysource || exit

DETAIN=false
if (whiptail --title "Android Skyscraper Installer" --yesno "Do you want to install Detain's/My fork instead of Muljord's original?" 8 78); then
    DETAIN=true
fi

if [ "$DETAIN" = true ]; then
if [ ! -d "Detain" ]; then
echo "Fetching latest Detain/My fork"
git clone https://github.com/SoumyBhow/skyscraper Detain
cd Detain || exit
else
echo "Updating Detain/My fork"
cd Detain || exit
git pull
fi
echo "Compiling"
qmake
make
make install
else
if [ ! -d "Muljdord" ]; then
mkdir -p ./Muldjord && cd ./Muldjord || exit
echo 'Downloading source and compiling Skyscraper'
wget -q -O - https://raw.githubusercontent.com/muldjord/skyscraper/master/update_skyscraper.sh | bash
else
echo "Updating Muldjord's Original"
cd ./Muldjord || exit
./update_skyscraper.sh
fi

echo 'Manually copying the Skyscraper binary to /usr/bin...'


cp Skyscraper "$PATH"/Skyscraper
echo 'Making the Skyscraper binary executable...'


chmod +x "$PATH"/Skyscraper
fi
echo 'Done! Please run the Skyscraper command to make sure it works'

read -n 1 -r -s -p $'Press any key to continue...\n'

