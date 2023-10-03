
Debian
====================
This directory contains files used to package gigaddikd/gigaddik-qt
for Debian-based Linux systems. If you compile gigaddikd/gigaddik-qt yourself, there are some useful files here.

## gigaddik: URI support ##


gigaddik-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install gigaddik-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your gigaddik-qt binary to `/usr/bin`
and the `../../share/pixmaps/gigaddik128.png` to `/usr/share/pixmaps`

gigaddik-qt.protocol (KDE)

