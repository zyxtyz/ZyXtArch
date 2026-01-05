#!/bin/sh 

install_bspwm() {
  echo "==> Installing bspwm and required packages..."
  sudo pacman -S --noconfirm --needed bspwm sxhkd feh
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

  echo "==> Installing additional packages with paru..."
  yay -S --noconfirm flameshot fzf neovim cava kitty wallust \
    xdg-desktop-portal-wlr-git xdg-utils xorg-init xorg-server zsh \
    ewwii zinit mpd mpc rmpc yt-dlp bc nerd-fonts vivaldi picom \
    playerctl
  echo "==> Cloning ZyXtArch repo..."
cd "$HOME"

git clone https://github.com/zyxtyz/ZyXtArch >/dev/null 2>&1
mkdir ~/.config >/dev/null 2>&1
cp -r "$HOME/ZyXtArch" "$HOME/.config/zyxtarch" >/dev/null 2>&1



echo "==> Checking if paru is installed..."
if command -v yay >/dev/null 2>&1; then
  echo "Installed!"
else
  echo "==> Yay not installed.."
  echo "==> Installing Yay (AUR helper)..."
  sudo pacman -S --noconfirm --needed base-devel
  cd "$HOME"
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm >/dev/null 2>&1
  cd "$HOME"
  rm -rf yay 
fi





echo "==> Setting up zsh..."
touch ~/.zshrc
echo "source ~/.config/zyxtarch/zsh/.zshrc" > ~/.zshrc
chsh -s /bin/zsh


mkdir ~/Music

echo "==> Fetching font .OTF and setting up font..."
git clone https://github.com/g5becks/Cartograph.git ~/font
rice font $HOME/font/CartographCF-BoldItalic.otf
rm -rf $HOME/*


echo "==> Cleaning..."
rm -rf $HOME/*
mkdir $HOME/{Music,Downloads}
echo "==> Setup complete! Rebooting system..."
sudo reboot

}

install_hyprland() {
  echo "==> Installing Hyprland"
  sudo pacman -S --noconfirm --needed hyprland

  echo "==> Installing packages that are needed for the rice..."
  yay -S --noconfirm hyprshot fzf neovim cava kitty wallust \
    xdg-desktop-portal-hyprland-git zsh ewwii zinit mpd mpc rmpc \
    yt-dlp bc nerd-fonts vivaldi picom playerctl swww

  echo "==> Cloning ZyXtArch repo..."
cd "$HOME"

git clone https://github.com/zyxtyz/ZyXtArch >/dev/null 2>&1
mkdir ~/.config >/dev/null 2>&1
cp -r "$HOME/ZyXtArch" "$HOME/.config/zyxtarch" >/dev/null 2>&1



echo "==> Checking if paru is installed..."
if command -v yay >/dev/null 2>&1; then
  echo "Installed!"
else
  echo "==> Yay not installed.."
  echo "==> Installing Yay (AUR helper)..."
  sudo pacman -S --noconfirm --needed base-devel
  cd "$HOME"
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm >/dev/null 2>&1
  cd "$HOME"
  rm -rf yay 
fi





echo "==> Setting up zsh..."
touch ~/.zshrc
echo "source ~/.config/zyxtarch/zsh/.zshrc" > ~/.zshrc
chsh -s /bin/zsh


mkdir ~/Music

echo "==> Fetching font .OTF and setting up font..."
git clone https://github.com/g5becks/Cartograph.git ~/font
rice font $HOME/font/CartographCF-BoldItalic.otf
rm -rf $HOME/*


echo "==> Cleaning..."
rm -rf $HOME/*
mkdir $HOME/{Music,Downloads}
echo "==> Setup complete! Rebooting system..."
sudo reboot
}


echo "What WM do you want?"
echo "hyprland"
echo "bspwm"
echo "selection >>>" 
read wm
select wm in bspwm hyprland; do
  case $wm in
    bspwm)
      install_bspwm
      break
      ;;
    hyprland)
      install_hyprland
      break
      ;;
    *)
      echo "Invalid selection, choose hyprland or bspwm"
      ;;
  esac
done



