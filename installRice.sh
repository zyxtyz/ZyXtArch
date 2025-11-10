#!/bin/sh  # Exit immediately on any error

echo "==> Installing git and required packages..."
sudo pacman -S --noconfirm --needed git bspwm sxhkd

echo "==> Cloning ZyXtArch repo..."
cd "$HOME"

git clone https://github.com/zyxtyz/ZyXtArch
mkdir ~/.config
mv "$HOME/ZyXtArch" "$HOME/.config/zyxtarch"

echo "==> Creating bspwm-zyxtarch session file..."
sudo mkdir -p /usr/share/xsessions/
sudo tee /usr/share/xsessions/bspwm-zyxtarch.desktop > /dev/null <<'EOF'
[Desktop Entry]
Name=bspwm (zyxtarch)
Comment=BSPWM - ZyxtArch
Exec=bspwm -c ~/.config/zyxtarch/bspwm/bspwmrc
Type=Application
DesktopNames=bspwm
EOF

echo "==> Installing paru (AUR helper)..."
sudo pacman -S --noconfirm --needed base-devel
cd "$HOME"
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si --noconfirm
cd "$HOME"
rm -rf paru

echo "==> Adding custom binaries to /usr/local/bin..."
cd "$HOME/.config/zyxtarch/bin"
sudo cp rice /usr/local/bin/
sudo cp tui-pacman /usr/local/bin/

echo "==> Installing additional packages with paru..."
paru -S --noconfirm flameshot fzf neovim cava kitty wallust-git \
  xdg-desktop-portal-wlr-git xdg-utils xorg-init xorg-server zsh

echo "==> Setup complete! Rebooting system..."
sudo reboot
