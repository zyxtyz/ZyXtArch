#!/usr/bin/bash
set -e

confirm() {
  read -rp ">> $1 [y/N]: " choice
  case "$choice" in
    y|Y|yes|YES) return 0 ;;
    *) return 1 ;;
  esac
}

ensure_yay() {
  if command -v yay >/dev/null 2>&1; then
    echo "==> yay already installed"
  else
    if confirm "yay is not installed. Install yay?"; then
      sudo pacman -S --needed --noconfirm base-devel git
      cd "$HOME"
      git clone https://aur.archlinux.org/yay.git
      cd yay
      makepkg -si --noconfirm
      cd "$HOME"
      rm -rf yay
    else
      echo "==> yay is required. Exiting."
      exit 1
    fi
  fi
}

setup_zsh() {
  if confirm "Set up zsh and make it default shell?"; then
    sudo pacman -S --needed --noconfirm zsh
    mkdir -p ~/.config/zyxtarch
    grep -q zyxtarch ~/.zshrc 2>/dev/null || \
      echo 'source ~/.config/zyxtarch/zsh/.zshrc' >> ~/.zshrc
    chsh -s /bin/zsh || true
  fi
}

install_fonts() {
  if confirm "Install Cartograph font?"; then
    mkdir -p ~/.local/share/fonts
    git clone https://github.com/g5becks/Cartograph.git /tmp/cartograph
    cp /tmp/cartograph/*.otf ~/.local/share/fonts/
    fc-cache -fv
    rm -rf /tmp/cartograph
  fi
}

clone_config() {
  if confirm "Clone ZyXtArch config repo?"; then
    mkdir -p ~/.config
    [ -d "$HOME/.config/zyxtarch" ] || \
      git clone https://github.com/zyxtyz/ZyXtArch ~/.config/zyxtarch
  fi
}

install_bspwm() {
  echo "==> BSPWM selected"

  if confirm "Install bspwm and required packages?"; then
    sudo pacman -S --needed --noconfirm bspwm sxhkd feh xorg-server xorg-xinit
  fi

  if confirm "Create bspwm display manager session file?"; then
    sudo tee /usr/share/xsessions/bspwm-zyxtarch.desktop >/dev/null <<'EOF'
[Desktop Entry]
Name=bspwm (ZyXtArch)
Comment=BSPWM - ZyXtArch
Exec=bspwm -c ~/.config/zyxtarch/bspwm/bspwmrc
Type=Application
DesktopNames=bspwm
EOF
  fi

  ensure_yay

  if confirm "Install additional bspwm rice packages?"; then
    yay -S --needed --noconfirm \
      flameshot fzf neovim cava kitty wallust \
      xdg-desktop-portal-wlr \
      ewwii mpd mpc yt-dlp bc nerd-fonts \
      picom playerctl
  fi

  clone_config
  setup_zsh
  install_fonts
}

install_hyprland() {
  echo "==> Hyprland selected"

  if confirm "Install Hyprland?"; then
    sudo pacman -S --needed --noconfirm hyprland
  fi

  ensure_yay

  if confirm "Install additional Hyprland rice packages?"; then
    yay -S --needed --noconfirm \
      hyprshot fzf neovim cava kitty wallust \
      xdg-desktop-portal-hyprland \
      ewwii mpd mpc yt-dlp bc nerd-fonts \
       playerctl swww
  fi

  clone_config
  setup_zsh
  install_fonts
}

echo "Select your Window Manager:"
echo "1) bspwm"
echo "2) hyprland"
read -rp "Selection: " wm

case "$wm" in
  1|bspwm) install_bspwm ;;
  2|hyprland) install_hyprland ;;
  *) echo "Invalid selection"; exit 1 ;;
esac

if confirm "Reboot system now?"; then
  sudo reboot
fi

echo "==> Installation finished."
