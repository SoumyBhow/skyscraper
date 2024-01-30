#!/bin/bash
echo 'Creating and moving into source folder "Skyscraper"...'
mkdir -p ./Skyscraper && cd ./Skyscraper || exit
pkg install git wget ffmpeg build-essential x11-repo -y
pkg install qt5-qmake

if [ ! -d "Gemba" ]; then
echo "Fetching latest Gemba fork"
git clone https://github.com/gemba/skyscraper -b master Gemba
cd Gemba || exit
else
echo "Updating Gemba fork"
cd Gemba || exit
git fetch --all
git reset --hard origin/master
fi

echo "Making Skyscraper compatible with Termux"

sed -i 's|usr/local|data/data/com.termux/files/usr|g' skyscraper.pro
sed -i 's|usr/local|data/data/com.termux/files/usr|g' ./src/config.cpp
sed -i 's|usr/local|data/data/com.termux/files/usr|g' ./supplementary/scraperdata/check_screenscraper_json_to_idmap.py
sed -i 's|usr/local|data/data/com.termux/files/usr|g' ./supplementary/scraperdata/peas_and_idmap_verify.py

echo "Compiling"
qmake
make
make install


echo 'Manually copying the Skyscraper binary to /usr/bin...'


cp Skyscraper "$PATH"/Skyscraper
echo 'Making the Skyscraper binary executable...'


chmod +x "$PATH"/Skyscraper
fi
echo 'Done! Please run the Skyscraper command to make sure it works'

cd "$(dirname "$0")"

