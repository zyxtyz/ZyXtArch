#!/bin/sh 

echo "==> Installing git and required packages..."
sudo pacman -S --noconfirm --needed git bspwm sxhkd feh

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

if command -v paru then	
	echo "Paru is installed!"
else
echo "==> Installing paru (AUR helper)..."
sudo pacman -S --noconfirm --needed base-devel
cd "$HOME"
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si --noconfirm
cd "$HOME"
rm -rf paru

fi
echo "==> Adding custom binaries to /usr/local/bin..."
cd "$HOME/.config/zyxtarch/bin"
sudo cp rice /usr/local/bin/
sudo cp tui-pacman /usr/local/bin/

echo "==> Installing additional packages with paru..."
paru -S --noconfirm flameshot fzf neovim cava kitty wallust-git \
  xdg-desktop-portal-wlr-git xdg-utils xorg-init xorg-server zsh \
  eww-git nushell zinit-git mpd mpc ncmpcpp yt-dlp bc nerd-fonts

mkdir ~/Music

echo "==> Fetching font .OTF and setting up font..."
curl -L https://github.com/g5becks/Cartograph/blob/main/CartographCF-BoldItalic.otf -o $HOME
rice font $HOME/CartographCF-BoldItalic.otf





echo "==> Cleaning..."
rm -rf $HOME/{CartographCF-BoldItalic.otf,ZyXtArch}
echo "==> Setup complete! Rebooting system..."
sudo reboot
