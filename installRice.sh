#!/bin/bash
set -e

# ------------------------
# Helper functions
# ------------------------

confirm() {
  read -rp ">> $1 [y/N]: " choice
  case "$choice" in
    y|Y|yes|YES) return 0 ;;
    *) return 1 ;;
  esac
}

is_installed() {
  pacman -Qi "$1" &>/dev/null
}

install_pacman_packages() {
  local pkgs=()
  for pkg in "$@"; do
    if is_installed "$pkg"; then
      echo "==> $pkg already installed"
    else
      pkgs+=("$pkg")
    fi
  done

  if [ "${#pkgs[@]}" -gt 0 ]; then
    echo "==> Installing missing pacman packages: ${pkgs[*]}"
    sudo pacman -S --needed --noconfirm "${pkgs[@]}"
  else
    echo "==> All pacman packages already installed"
  fi
}

install_yay_packages() {
  ensure_yay

  local pkgs=()
  for pkg in "$@"; do
    if is_installed "$pkg"; then
      echo "==> $pkg already installed"
    else
      pkgs+=("$pkg")
    fi
  done

  if [ "${#pkgs[@]}" -gt 0 ]; then
    echo "==> Installing missing AUR packages: ${pkgs[*]}"
    yay -S --needed --noconfirm "${pkgs[@]}"
  else
    echo "==> All AUR packages already installed"
  fi
}

ensure_yay() {
  if command -v yay >/dev/null 2>&1; then
    echo "==> yay already installed"
  else
    if confirm "yay is not installed. Install yay?"; then
      install_pacman_packages base-devel git
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
    install_pacman_packages zsh
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

# ------------------------
# Install BSPWM
# ------------------------

install_bspwm() {
  echo "==> BSPWM selected"

  if confirm "Install bspwm and required packages?"; then
    install_pacman_packages bspwm sxhkd feh xorg-server xorg-xinit
  fi

  if confirm "Create bspwm display manager session file?"; then
    sudo tee /usr/share/xsessions/bspwm-zyxtarch.desktop >/dev/null <<'EOF'
[Desktop Entry]
Name=BSPWM (ZyXtArch)
Comment=BSPWM - ZyXtArch
Exec=bspwm -c /home/$USER/.config/zyxtarch/bspwm/bspwmrc
Type=Application
DesktopNames=bspwm
EOF
  fi

  install_yay_packages \
    flameshot fzf neovim cava kitty wallust \
    xdg-desktop-portal-wlr \
    ewwii mpd mpc yt-dlp bc nerd-fonts \
    picom playerctl

  clone_config
  setup_zsh
  install_fonts
}

# ------------------------
# Install Hyprland
# ------------------------

install_hyprland() {
  echo "==> Hyprland selected"

  if confirm "Install Hyprland?"; then
    install_pacman_packages hyprland
  fi

  install_yay_packages \
    hyprshot fzf neovim cava kitty wallust \
    xdg-desktop-portal-hyprland \
    ewwii mpd mpc yt-dlp bc nerd-fonts \
    playerctl swww

  if confirm "Create Hyprland Wayland session file?"; then
    sudo tee /usr/share/wayland-sessions/hyprland-zyxtarch.desktop >/dev/null <<'EOF'
[Desktop Entry]
Name=Hyprland (ZyXtArch)
Comment=Hyprland - ZyXtArch
Exec=Hyprland
Type=Application
EOF
  fi

  clone_config
  setup_zsh
  install_fonts
}

# ------------------------
# Main menu
# ------------------------

echo "Select your Window Manager:"
echo "1) bspwm"
echo "2) hyprland"
read -rp "Selection: " wm
wm="$(echo "$wm" | tr -d '[:space:]')"

case "$wm" in
  1|bspwm|BSPWM) install_bspwm ;;
  2|hyprland|HYPRLAND) install_hyprland ;;
  *) echo "Invalid selection"; exit 1 ;;
esac

if confirm "Reboot system now?"; then
  sudo reboot
fi

echo "==> Installation finished."
