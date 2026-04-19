#!/usr/bin/env bash

set -euo pipefail

REPO_DIR="$HOME/Mi3"
BACKUP_DIR="$HOME/.mi3-backup-$(date +%s)"

echo "[*] Starting Mi3 setup..."
mkdir -p "$BACKUP_DIR"

# -------------------------------
# Install yay if not present
# -------------------------------
if ! command -v yay &>/dev/null; then
    echo "[*] Installing yay..."
    sudo pacman -S --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git
    pushd yay
    makepkg -si --noconfirm
    popd
    rm -rf yay
else
    echo "[*] yay already installed"
fi

# -------------------------------
# Clone repo if not exists
# -------------------------------
if [ ! -d "$REPO_DIR" ]; then
    echo "[*] Cloning Mi3 repo..."
    git clone https://github.com/notmish/Mi3.git "$REPO_DIR"
else
    echo "[*] Repo already exists at $REPO_DIR"
fi

cd "$REPO_DIR"

# -------------------------------
# Install packages
# -------------------------------
echo "[*] Installing pacman packages..."
sudo pacman -S --needed --noconfirm - < pkglist.txt

echo "[*] Installing AUR packages..."
yay -S --needed --noconfirm - < aur-pkglist.txt

# -------------------------------
# Backup function
# -------------------------------
backup_if_exists() {
    if [ -e "$1" ]; then
        echo "[*] Backing up $1"
        mkdir -p "$BACKUP_DIR$(dirname "$1")"
        mv "$1" "$BACKUP_DIR$1"
    fi
}

# -------------------------------
# Copy .config
# -------------------------------
echo "[*] Copying .config..."
mkdir -p "$HOME/.config"
cp -r .config/* "$HOME/.config/"

# -------------------------------
# Move files
# -------------------------------
echo "[*] Moving dotfiles..."

backup_if_exists "$HOME/.fehbg"
cp .fehbg "$HOME/"

mkdir -p "$HOME/.local"
cp -r .local/* "$HOME/.local/"

backup_if_exists "$HOME/Pictures"
cp -r Pictures "$HOME/"

backup_if_exists "$HOME/.bashrc"
cp .bashrc "$HOME/.bashrc"

backup_if_exists "$HOME/.Xresources"
cp .Xresources "$HOME/"

# -------------------------------
# System config
# -------------------------------
echo "[*] Installing picom config..."
sudo cp picom.conf /etc/xdg/

# -------------------------------
# Permissions
# -------------------------------
echo "[*] Setting executable permissions..."
chmod +x "$HOME/.fehbg" || true
chmod +x "$HOME/.local/bin/"*.sh || true

# -------------------------------
# Cleanup temp file
# -------------------------------
rm -f "$HOME/.local/deleteme.jpg" || true

# -------------------------------
# Optional: Enable SDDM
# -------------------------------
read -rp "[?] Enable SDDM display manager? (y/N): " enable_sddm
if [[ "$enable_sddm" =~ ^[Yy]$ ]]; then
    sudo systemctl enable sddm
    echo "[*] SDDM enabled"
fi

# -------------------------------
# Reload Xresources
# -------------------------------
xrdb "$HOME/.Xresources" || true

echo "[✔] Installation complete!"
echo "[!] Backup stored at: $BACKUP_DIR"
echo "[!] Reboot and select i3 session."
