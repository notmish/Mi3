# Mi3
A lazy way to store my minimal Archlinux i3 dotfiles so I can recover my bare system anytime later

## Requirements
Archlinux minimal installed(either via archinstalled script or mannual), yay installed, all graphics drivers, bluetooth, touchpad(for laptop),wifi setted up.
I use sddm so I dont have xinit or stuff. 
To enable sddm use (do it at the last of Installation)
```bash
sudo systemctl enable sddm
```
### Install yay (AUR helper)
```bash
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay
```

## Installation 
1. cd into the the newly cloned folder (DO NOT GO OUT OF THIS BEFORE FINISHING THIS MANNUAL SETUP)
2. copy all the files inside .config to your ~/.config
```bash
cp -r .config/* ~/.config/
```
move .fehbg to ~/
```bash
mv .fehbg ~/
```
move .local to ~/
```bash
mv .local/* ~/.local/
```
move Pictures to ~/
```bash
mv Pictures ~/
```
move .bashrc to ~/
```bash
mv ~/.bashrc ~/.bashrc.backup
cp .bashrc ~/.bashrc
```
move picom.conf to /etc/xdg/
```bash
sudo mv picom.conf /etc/xdg/
```

3. install the pacman and yay packages.
   for pacman
```bash
sudo pacman -S --needed - < pkglist.txt
```
  for yay
```bash
yay -S --needed - < aur-pkglist.txt
```
4. make all the executables executable for useage(use sudo if shows error)
fehbg for wallpaper
```bash
chmod +x ~/.fehbg
```
two of the screenshot scripts (use sudo if gets error)
```bash
cd ~/.local/bin
chmod +x screenshot-select.sh screenshot.sh
```
Now reboot the system.
after rebooting start i3 session and from lxappearance select Materia-dark on widget, Papirus-Dark on icon and Bibata-Modern-Ice on mouse cursor.
### There's three tmp file inside .local, Pictures and Pictures/screenshot. kindly delete them
##REBOOT
