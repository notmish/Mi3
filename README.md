# Mi3
my minimal Archlinux i3 dotfiles for me to recover my bare system anytime later

feel free to edit stuff or copy it as you need.

made on my potato laptop to make it work faster as I had more important stuff on desktop

Its minimal uses like 300 mb on idle
Its a minimal black & white theme
![i3 desktop](Pictures/screenshot/screenshot.png)

## Requirements
Archlinux minimal installed(either via archinstalled script or mannual), yay installed, all graphics drivers, bluetooth, touchpad(for laptop),wifi setted up.
I use sddm so I dont have xinit or stuff. 
To enable sddm use 
(do it at the last of Installation)
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
Clone the repo
```bash
cd ~
git clone https://github.com/notmish/Mi3.git
```
### 1.
cd into the the newly cloned folder ~/Mi3 (DO NOT GO OUT OF THIS BEFORE FINISHING THIS MANNUAL SETUP)
### 2.
copy all the files inside (in case folders dosent exists then create them!) .config to your ~/.config
```bash
cp -r ~/Mi3/.config/* ~/.config/
```
move .fehbg to ~/
```bash
mv ~/Mi3/.fehbg ~/
```
move .local to ~/
```bash
mv ~/Mi3/.local/* ~/.local/
```
move Pictures to ~/
```bash
mv ~/Mi3/Pictures ~/
```
move .bashrc to ~/
```bash
mv ~/.bashrc ~/.bashrc.backup
cp ~/Mi3/.bashrc ~/.bashrc
```
move picom.conf to /etc/xdg/
```bash
sudo mv ~/Mi3/picom.conf /etc/xdg/
```
if youre on virtual machine make sure to turn off vsync on picom.conf else picom wont work
move .Xresources to ~/
```bash
mv ~/Mi3/.Xresources ~/
```

### 3.
install the pacman and yay packages.
   for pacman
```bash
cd ~/Mi3
sudo pacman -S --needed - < pkglist.txt
```
  for yay
```bash
cd ~/Mi3
yay -S --needed - < aur-pkglist.txt
```
### 4.
make all the executables executable for useage(use sudo if shows error)
fehbg for wallpaper
```bash
chmod +x ~/.fehbg
```
two of the screenshot scripts (use sudo if gets error)
```bash
cd ~/.local/bin
chmod +x screenshot-select.sh screenshot.sh
```
## Extra
for laptops you need to go into ~/.cofnig/i3status/i3status.conf and remove "#" from "#order += "battery all""

Now reboot the system.
after rebooting start i3 session and from lxappearance select Materia-dark on widget, Papirus-Dark on icon and Bibata-Modern-Ice on mouse cursor.
do this for proper mouse cursor view:
```bash
xrdb ~/.Xresources
```
### There's three tmp files inside .local, Pictures and Pictures/screenshot. kindly delete them. If i do my files gets messed up on github
## REBOOT

# ⌨️ i3 Keybindings (Mod4 = Super key)

This is a custom configuration for i3 window manager.

---

##  Core Apps

- Terminal: `Mod + Enter`
- File Manager: `Mod + F`
- Browser: `Mod + B`
- Close Window: `Mod + Q`
- App Launcher (rofi): `Mod + D`

---

##  Focus Windows

- Left: `Mod + J` or `Mod + Left`
- Down: `Mod + K` or `Mod + Down`
- Right: `Mod + ;` or `Mod + Right`
- Up: `Mod + Up`

---

##  Move Windows

- Left: `Mod + Shift + J`
- Down: `Mod + Shift + K`
- Up: `Mod + Shift + L`
- Right: `Mod + Shift + ;`

(Arrow keys also work with Shift)

---

##  Layout Controls

- Split Horizontal: `Mod + H`
- Split Vertical: `Mod + V`
- Fullscreen: `Mod + Shift + F`
- Toggle Floating: `Mod + Shift + Space`
- Toggle Focus Floating/Tiling: `Mod + Space`
- Stacking Layout: `Mod + S`
- Tabbed Layout: `Mod + W`
- Toggle Split: `Mod + E`
- Focus Parent: `Mod + A`

---

##  Workspaces

- Switch workspace 1–10: `Mod + 1 ... Mod + 0`
- Move window to workspace: `Mod + Shift + 1 ... Mod + Shift + 0`

---

##  System Controls

- Reload config: `Mod + Shift + C`
- Restart i3: `Mod + Shift + R`
- Exit i3: `Mod + Shift + E`

---

##  Volume Controls

- Volume Up: `Mod + Alt + Right`
- Volume Down: `Mod + Alt + Left`
- Mute: `Mod + Alt + M`
- Mic Mute: `XF86AudioMicMute`

---

##  Brightness

- Increase: `Mod + Alt + Up`
- Decrease: `Mod + Alt + Down`

---

##  Screenshots

- Fullscreen: `Mod + Print`
- Area Select: `Mod + Shift + Print`

Scripts:
- `~/.local/bin/screenshot.sh`
- `~/.local/bin/screenshot-select.sh`

---

##  Utilities

- Notification history: `Mod + N`
- Lock screen: `Mod + L`

---

##  Notes

- Mod key = Super (Windows key)
- Uses tiling workflow with floating support
- Wallpaper set via feh
- Compositor: picom
- Notifications: dunst
### theres a config code(copied from dacctal) for Stylus plugin. select Applyies to > Everything and and aslo type * inside the box under Edit style of left top, then paste the code inside Code section. It makes everything square.
