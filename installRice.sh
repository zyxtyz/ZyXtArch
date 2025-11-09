echo "installing git and other requires packages"
sudo pacman -S git bspwm sxhkd

cd $HOME
echo "Cloning repo"
git clone https://github.com/zyxtyz/ZyXtArch

mv "$HOME"/ZyXtArch  ~/.config/zyxtarch

echo "making a session for bspwm-zyxtarch so you won't need backup"

sudo mkdir -p /usr/share/xsessions/

sudo touch /usr/share/xsessions/bspwm-zyxtarch.desktop

sudo cat <<'EOF' > /usr/share/xessions/bpswm-zyxtarch.desktop
[Desktop Entry]
Name=bspwm (zyxtarch)
Comment=BSPWM -zyxtarch
Exec=bspwm -c ~/.config/zyxtarch/bspwm/bspwmrc
Type=Application
DesktopNames=bspwm
EOF

cd ~
echo "Installing paru. password needed"
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

rm -rf paru

echo "adding binaries in /bin"
cd ~/.config/zyxtarch/bin
sudo cp rice /bin
sudo cp tui-pacman /bin
echo "installing packages"
paru -S flameshot fzf neovim cava kitty wallust-git xdg-desktop-portal-wlr-git xdg-utils xorg-init xorg-server zsh 

reboot

