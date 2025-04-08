#!/bin/sh
# WARN: include not all packages need update script after fresh install

# TODO: add sudo command

# Install yay
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
pushd yay
makepkg -si
popd; rm -rf yay

# Add color to pacman/yay 
sudo sed -i 's/^#Color/Color/' /etc/pacman.conf
# Add concurrent package download (5 by default)

# Add parrallel building
sudo sed -i 's/^#MAKEFLAGS/MAKEFLAGS/' /etc/pacman.conf
# Enable multilib
sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.d/mirrorlist
# Update 
yay -Suy

# Add fonts
yay -S noto-fonts-emoji

# System packages
# udisks2 use by yazi plugin
yay -S networkmanager nvidia udisks2
# Main sound
yay -S pipewire pipewire-alsa lib32-pipewire pipewire-pulse
# Screen sharing, duplicate pipewire
# https://wiki.hyprland.org/Useful-Utilities/Screen-Sharing/
yay -S xdg-desktop-portal-hyprland wireplumber pipewire

# Languages
# NOTE: clang (C/C++) contain lsp inside itself
# Python is default Linux package
yay -S clang cmake lua
# LSP languages
# Python Lua CMake Docker Bash Fish
yay -S pyright lua-language-server sqls neocmakelsp dockerfile-language-server-nodejs bash-language-server fish-lsp,
# Linters
yay -S ruff
# Python package manager
yay -S uv

# Workspace packages
yay -S foot
yay -S neovim fish nvim yazi fd fzf ripgrep zoxide lazygit btop
# Windowspace packages
yay -S hyprland hyprlock greetd fuzzel waybar
# Apps packages
yay -S telegram-desktop transmission-qt mpv shotwell zim # lutris
# Extra programms
yay -S pwvucontrol hyprshot
yay -S nekoray sing-geoip-db sing-geosite-db
# WARN:  `ddcutil`` does not support brightness for laptop monitors, which do not implement DDC/CI
# But `brightnessctl` does, in that case need also fix `$HOME/.config/hypr/hypridle.conf` and sleep/wake_up scripts
yay -S ddcutil

# Make fish default shell
chsh --shell /bin/fish

# Project libraries
# yay -S docker lazydocker
yay -S postgresql gitea

# Setup greeter
# https://wiki.archlinux.org/title/Greetd#Greeter_configuration
sudo sed -i 's/^command = agreety --cmd .*/command = agreety --cmd Hyprland/' /etc/greetd/config.toml

# Yazi extra
# Extent work packages 
yay -S bat hexyl glow
# WARN: need to be sure plugins are ok
ya pack -i

# Lutris wine
# https://github.com/lutris/docs/blob/master/WineDependencies.md
sudo pacman -S wine-staging
sudo pacman -S --needed --asdeps giflib lib32-giflib gnutls lib32-gnutls v4l-utils lib32-v4l-utils libpulse \
lib32-libpulse alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib sqlite lib32-sqlite libxcomposite \
lib32-libxcomposite ocl-icd lib32-ocl-icd libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs \
lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader sdl2 lib32-sdl2

# NOTE: below tridactyl scripts need to be set inside firefox
# :source: ~/.config/tridactyl/.tridactyl
# TODO: change dracula scheme. Current one is so big blocks and annoy
# :colourscheme --url https://raw.githubusercontent.com/dracula/tridactyl/main/dracula.css dracula

# Firefox and it's custom profile
yay -S firefox tridactyl
# Set firefox default profile
# WARN: not sure if okay, need clean install test
PROFILE_NAME="zndrsg72.sandy"
DEFAULT_FIREFOX_PATH="$HOME/.mozilla/firefox"
PROFILE_PATH=$DEFAULT_FIREFOX_PATH/$PROFILE_NAME
firefox -CreateProfile "$PROFILE_NAME"
# WARN: Not sure will profile menu appear without this
# echo "
# [General]
# StartWithLastProfile=1
#
# [Profile0]
# Name=$PROFILE_NAME
# IsRelative=1
# Path=$(basename "$PROFILE_PATH")
# Default=1" >> "$DEFAULT_FIREFOX_PATH/profiles.ini" 
firefox -P "$PROFILE_NAME" --no-remote &
