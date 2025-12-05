#!/bin/sh 

echo "==> Installing git and required packages..."
sudo pacman -S --noconfirm --needed git bspwm sxhkd feh >/dev/null 2>&1

echo "==> Cloning ZyXtArch repo..."
cd "$HOME"

git clone https://github.com/zyxtyz/ZyXtArch >/dev/null 2>&1
mkdir ~/.config >/dev/null 2>&1
cp -r "$HOME/ZyXtArch" "$HOME/.config/zyxtarch" >/dev/null 2>&1

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

echo "==> Checking if paru is installed..."
if command -v paru >/dev/null 2>&1; then
  echo "Installed!"
else
  echo "==> Paru not installed.."
  echo "==> Installing paru (AUR helper)..."
  sudo pacman -S --noconfirm --needed base-devel
  cd "$HOME"
  git clone https://aur.archlinux.org/paru.git
  cd paru
  makepkg -si --noconfirm >/dev/null 2>&1
  cd "$HOME"
  rm -rf paru 
fi



echo "==> Installing additional packages with paru..."
paru -S --noconfirm flameshot fzf neovim cava kitty wallust-git \
  xdg-desktop-portal-wlr-git xdg-utils xorg-init xorg-server zsh \
  eww-git nushell zinit-git mpd mpc ncmpcpp yt-dlp bc nerd-fonts vivaldi

echo "==> Setting up zsh..."
touch ~/.zshrc
echo "source ~/.config/zyxtarch/zsh/.zshrc" > ~/.zshrc
chsh -s /bin/zsh


mkdir ~/Music

echo "==> Fetching font .OTF and setting up font..."
curl -L https://github.com/g5becks/Cartograph/blob/main/CartographCF-BoldItalic.otf -o $HOME
rice font $HOME/CartographCF-BoldItalic.otf





echo "==> Cleaning..."
rm -rf $HOME/*
mkdir $HOME/{Music,Downloads}
echo "==> Setup complete! Rebooting system..."
sudo reboot
