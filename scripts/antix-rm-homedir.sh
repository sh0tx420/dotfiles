#!/bin/bash
sudo rm -rfv .cache/ .dbus/ .desktop-session/ .dillo/ .foxrc/ .fluxbox/ .gconf/ .jwm/ .mcthemes/ .screenlayout/ .xmms/ .newsboat/ .icewm/ .icons/
sudo rm -rfv Desktop/ Documents/ Downloads/ Music/ Pictures/ Videos/
sudo rm -fv .conky* .gexec  .gtk* .jwm* .nanorc .Xauthority .Xresources .smb* .fehbg
echo 'Cleaned home directory. Please remove antix-rm-homedir.sh.'
