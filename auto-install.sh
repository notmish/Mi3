#!/usr/bin/env bash

set -euo pipefail

REPO_DIR="$HOME/Mi3"

echo "[*] Starting Mi3 setup..."

# -------------------------------
# Sudo keep-alive (one password prompt)
# -------------------------------
echo "[*] Requesting sudo access..."
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# -------------------------------
# Yay check (FIRST)
# -------------------------------
if ! command -v yay &>/dev/null; then
    read -rp "[?] yay is not installed. Install it? (Y/n): " install_yay
    install_yay=${install_yay:-Y}

    if [[ "$install_yay" =~ ^[Yy]$ ]]; then
        echo "[*] Installing yay..."
        sudo pacman -S --needed --noconfirm git base-devel
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si --noconfirm
        cd ..
        rm -rf yay
    else
        echo "[!] yay is required. Exiting."
        exit 1
    fi
fi

# -------------------------------
# Clone repo if needed
# -------------------------------
if [ ! -d "$REPO_DIR" ]; then
    echo "[*] Cloning Mi3 repo..."
    git clone https://github.com/notmish/Mi3.git "$REPO_DIR"
fi

cd "$REPO_DIR"

# -------------------------------
# Install packages (pacman -> yay)
# -------------------------------
echo "[*] Installing pacman packages..."
sudo pacman -S --needed --noconfirm - < pkglist.txt

echo "[*] Installing AUR packages..."
yay -S --needed --noconfirm - < aur-pkglist.txt

# -------------------------------
# Move / copy files
# -------------------------------
echo "[*] Placing configuration files..."

mkdir -p "$HOME/.config"
mkdir -p "$HOME/.local"

cp -r .config/* "$HOME/.config/"
mv .fehbg "$HOME/"
cp -r .local/* "$HOME/.local/"
mv Pictures "$HOME/"

# bashrc (with backup like manual)
if [ -f "$HOME/.bashrc" ]; then
    mv "$HOME/.bashrc" "$HOME/.bashrc.backup"
fi
cp .bashrc "$HOME/.bashrc"

mv .Xresources "$HOME/"

# system config
sudo mv picom.conf /etc/xdg/

# -------------------------------
# Permissions
# -------------------------------
echo "[*] Setting executable permissions..."

chmod +x "$HOME/.fehbg"

if [ -d "$HOME/.local/bin" ]; then
    chmod +x "$HOME/.local/bin/"*.sh 2>/dev/null || true
fi

# -------------------------------
# SDDM choice
# -------------------------------
read -rp "[?] Use SDDM display manager? (Y/n): " use_sddm
use_sddm=${use_sddm:-Y}

if [[ "$use_sddm" =~ ^[Yy]$ ]]; then
    echo "[*] Enabling SDDM..."
    sudo systemctl enable sddm
else
    echo "[*] Removing SDDM..."
    sudo pacman -Rns --noconfirm sddm
fi

# -------------------------------
# Cleanup
# -------------------------------
rm -f "$HOME/.local/deleteme.jpg"

# reload Xresources
xrdb "$HOME/.Xresources" 2>/dev/null || true

echo "[✔] Installation complete!"
echo "[!] Reboot and start i3."
