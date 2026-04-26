#!/bin/bash
set -euo pipefail

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
  pacman -Q "$1" &>/dev/null
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

  if [ ${#pkgs[@]} -gt 0 ]; then
    echo "==> Installing pacman packages: ${pkgs[*]}"
    sudo pacman -S --needed --noconfirm "${pkgs[@]}"
  else
    echo "==> All pacman packages already installed"
  fi
}

ensure_yay() {
  if command -v yay >/dev/null 2>&1; then
    echo "==> yay already installed"
    return
  fi

  echo "==> Installing yay (AUR helper)..."
  install_pacman_packages base-devel git

  cd "$HOME"
  rm -rf yay
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
  cd "$HOME"
  rm -rf yay
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

  if [ ${#pkgs[@]} -gt 0 ]; then
    echo "==> Installing AUR packages: ${pkgs[*]}"
    yay -S --needed --noconfirm "${pkgs[@]}"
  else
    echo "==> All AUR packages already installed"
  fi
}

# ------------------------
# ZSH setup
# ------------------------

setup_zsh() {
  if confirm "Install and configure Zsh?"; then
    install_pacman_packages zsh

    mkdir -p ~/.config/zyxtarch

    if ! grep -q "zyxtarch" ~/.zshrc 2>/dev/null; then
      echo 'source ~/.config/zyxtarch/zsh/.zshrc' >> ~/.zshrc
    fi

    chsh -s /bin/zsh || true
  fi
}

# ------------------------
# Config clone
# ------------------------

clone_config() {
  mkdir -p ~/.config

  if [ ! -d "$HOME/.config/zyxtarch" ]; then
    echo "==> Cloning ZyXtArch config..."
    git clone https://github.com/zyxtyz/ZyXtArch ~/.config/zyxtarch
  else
    echo "==> Config already exists, skipping clone"
  fi
}

# ------------------------
# Install Hyprland
# ------------------------

install_hyprland() {
  echo "==> Hyprland setup"
  install_pacman_packages \
    waybar wl-clipboard grim slurp polkit-kde-agent

  install_yay_packages \
    hyprshot fzf neovim cava kitty wallust \
    xdg-desktop-portal-hyprland \
    aylurs-gtk-shell-git mpd mpc yt-dlp bc nerd-fonts \
    playerctl swww mpd-mpris
    sudo tee /usr/share/wayland-sessions/hyprland-zyxtarch.desktop >/dev/null <<EOF
[Desktop Entry]
Name=Hyprland (ZyXtArch)
Comment=Hyprland - ZyXtArch
Exec=Hyprland
Type=Application
EOF
  clone_config
  setup_zsh
}

# ------------------------
# Start installation
# ------------------------

install_hyprland

if confirm "Reboot system now?"; then
  sudo reboot
fi

echo "==> Installation finished."