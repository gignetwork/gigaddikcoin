#!/bin/bash
echo -e "\033[0;32mHow many CPU cores do you want to be used in compiling process? (Default is 1. Press enter for default.)\033[0m"
read -e CPU_CORES
if [ -z "$CPU_CORES" ]
then
    CPU_CORES=1
fi

# Upgrade the system and install required dependencies
	sudo apt -y install build-essential libssl-dev libdb++-dev libboost-all-dev libcrypto++-dev libqrencode-dev libminiupnpc-dev libgmp-dev libgmp3-dev autoconf autogen automake libtool autotools-dev pkg-config bsdmainutils software-properties-common libzmq3-dev libminiupnpc-dev libssl-dev libevent-dev
	sudo apt-get install curl librsvg2-bin libtiff-tools bsdmainutils cmake imagemagick libcap-dev libz-dev libbz2-dev python3-setuptools
	sudo apt-get install software-properties-common
	sudo add-apt-repository ppa:pivx/pivx
	sudo apt-get update
	sudo apt-get install libdb4.8-dev libdb4.8++-de

# Clone code from official Github repository
	rm -rf gigaddik
	git clone https://github.com/addiknetwork/gigaddikcoin.git

# Entering directory
	cd gigaddik

# Compile dependencies
	cd depends
	mkdir SDKs
	cd SDKs
	wget https://github.com/phracker/MacOSX-SDKs/releases/download/10.15/MacOSX10.11.sdk.tar.xz
	tar -xf MacOSX10.11.sdk.tar.xz
	cd ..
	make -j$(echo $CPU_CORES) HOST=x86_64-apple-darwin14
	cd ..

# Compile
	./autogen.sh
	./configure --prefix=$(pwd)/depends/x86_64-apple-darwin14 --enable-cxx --enable-static --disable-shared --disable-debug --disable-tests --disable-bench --disable-online-rust
	make -j$(echo $CPU_CORES) HOST=x86_64-apple-darwin14
	make deploy
	cd ..

# Create zip file of binaries
	cp gigaddik/src/gigaddikd gigaddik/src/gigaddik-cli gigaddik/src/gigaddik-tx gigaddik/src/qt/gigaddik-qt gigaddik/GigAddik-Core.dmg .
	zip gigaddik-MacOS.zip gigaddikd gigaddik-cli gigaddik-tx gigaddik-qt GigAddik-Core.dmg
	rm -f gigaddikd gigaddik-cli gigaddik-tx gigaddik-qt GigAddik-Core.dmg
