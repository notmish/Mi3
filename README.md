# Mi3
A lazy way to store my minimal Archlinux i3 dotfiles so I can recover my bare system anytime later

## Requirements
Archlinux minimal installed(either via archinstalled script or mannual), yay installed, all graphics drivers, bluetooth, touchpad(for laptop),wifi setted up.
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
