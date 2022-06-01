## Remove packages
Command: `sudo apt purge <packages>`
<br>
Run `sudo apt autoremove` in between every package group removal.

Following packages have to be removed:
- vim-common vim-tiny tmux mailcap
- xserver-common xserver-xorg-video-sis671 wallpaper-antix
- jwm icewm icewm-common herbstluftwm wmctrl
- fluxbox fluxbox-themes-antix fluxbox-base-themes-antix
- bluetooth gnome-bluetooth libbluetooth3 libgnome-bluetooth13 bluez bluez-firmware
- zsh-common ash
- apulse libpulse0
- adwaita-icon-theme arc-evopro2-theme-antix arc-theme breeze-amber-cursor-theme-antix breeze-snow-cursor-theme-antix clearlooks-phenix-theme dmz-cursor-theme gnome-themes-extra gnome-themes-extra-data hicolor-icon-theme niroki-theme-antix numix-gtk-theme oxy-black-cursor-theme-antix oxy-white-cursor-theme-antix prettypink-themes slimski-themes-extras-antix
- xfonts-base xfonts-100dpi xfonts-encodings xfonts-intl-asian xfonts-intl-european xfonts-intl-japanese xfonts-scalable xonts-terminus xfonts-utils
- xbitmaps xinit xutils-dev x11-apps
- desktop-defaults-base-antix desktop-defaults-core-antix desktop-defaults-full-antix
- gtk2-engines gtk2-engines-pixbuf gtk2-engines-murrine
- wpasupplicant wireless-regdb wireless-tools
- printer-driver-{brlaser,c2050,c2esp,cjet,cups-pdf,dymo,escpr,foo2zjs,foo2zjs-common,gutenprint,hpcups,hpijs,m2300w,min12xxw,pnm2ppa,postscript-hp,ptouch,pxljr,sag-gdi,splix}
- cups-common cups-core-drivers system-config-printer-udev cups-filters-core-drivers cups-filters
- x11-xfs-utils xfsprogs ntfs-3g libntfs-3g883
- mesa-utils mesa-va-drivers mesa-vdpau-drivers mesa-vulkan-drivers va-driver-all vdpau-driver-all intel-media-va-driver i965-va-driver
- qt5-style-plugin-{cleanlooks,motif,plastique} qt5ct

## Delete useless files from home dir
This repository contains a script to remove the files, steps below:
1. `wget raw.githubusercontent.com/sh0tx420/dotfiles/main/scripts/antix-rm-homedir.sh`
2. `chmod +x antix-rm-homedir.sh`
3. `./antix-rm-homedir.sh`
4. `rm -v antix-rm-homedir.sh`
