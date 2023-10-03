#!/bin/bash
echo -e "\033[0;32mHow many CPU cores do you want to be used in compiling process? (Default is 1. Press enter for default.)\033[0m"
read -e CPU_CORES
if [ -z "$CPU_CORES" ]
then
	CPU_CORES=1
fi

# Upgrade the system and install required dependencies
	sudo apt update
	sudo apt install git zip unzip build-essential libtool bsdmainutils autotools-dev autoconf pkg-config automake python3 curl g++-mingw-w64-i686 mingw-w64-i686-dev libqt5svg5-dev -y
	echo "1" | sudo update-alternatives --config i686-w64-mingw32-g++

# Clone code from official Github repository
	rm -rf gigaddik
	git clone https://github.com/addiknetwork/gigaddikcoin.git

# Entering directory
	cd gigaddik

# Compile dependencies
	cd depends
	make -j$(echo $CPU_CORES) HOST=i686-w64-mingw32 
	cd ..

# Compile
	./autogen.sh
	./configure --prefix=$(pwd)/depends/i686-w64-mingw32 --disable-debug --disable-tests --disable-bench --disable-online-rust CFLAGS="-O3" CXXFLAGS="-O3"
	make -j$(echo $CPU_CORES) HOST=i686-w64-mingw32
	cd ..

# Create zip file of binaries
	strip -s gigaddik/src/gigaddikd.exe gigaddik/src/gigaddik-cli.exe gigaddik/src/gigaddik-tx.exe gigaddik/src/qt/gigaddik-qt.exe
	cp gigaddik/src/gigaddikd.exe gigaddik/src/gigaddik-cli.exe gigaddik/src/gigaddik-tx.exe gigaddik/src/qt/gigaddik-qt.exe .
	zip gigaddik-windows32.zip gigaddikd.exe gigaddik-cli.exe gigaddik-tx.exe gigaddik-qt.exe
	rm -f gigaddikd.exe gigaddik-cli.exe gigaddik-tx.exe gigaddik-qt.exe
  
