#!/bin/sh
# WARN: include not all packages need update script after fresh install

# Install yay
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..; rm -rf yay

# Add color to pacman/yay 
sudo sed -i 's/^#Color/Color/' /etc/pacman.conf
# Add concurrent package download (5 by default)
# 99% it's now default
# sudo sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf

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

# Languages
# NOTE: clang (C/C++) contain lsp inside
# Python is default Linux package
yay -S clang cmake lua
# LSP languages
# Python Lua CMake Docker Bash Fish
yay -S pyright lua-language-server neocmakelsp dockerfile-language-server-nodejs bash-language-server fish-lsp
# Linters
yay -S ruff
# Python package manager
yay -S uv

# Project libraries
# TODO: check do i need ollama
yay -S docker lazydocker
yay -S postgre gitea

# Main system programms
yay -S hyprland waybar fuzzel lutris telegram-desktop transmission-qt mpv shotwell zim
# Lutris wine
# https://github.com/lutris/docs/blob/master/WineDependencies.md
sudo pacman -S wine-staging
sudo pacman -S --needed --asdeps giflib lib32-giflib gnutls lib32-gnutls v4l-utils lib32-v4l-utils libpulse \
lib32-libpulse alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib sqlite lib32-sqlite libxcomposite \
lib32-libxcomposite ocl-icd lib32-ocl-icd libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs \
lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader sdl2 lib32-sdl2
# AUR
# TODO: find better equalent, not this silly electron, please
yay -S nekoray sing-geoip-db sing-geosite-db
yay -S pwvucontrol hyprshot

# Main work packages
yay -S kitty fish nvim yazi fd fzf ripgrep zoxide lazygit btop
# Extent work packages 
yay -S bat hexyl glow

# Make fish default shell
chsh --shell /bin/fish
# Install yazi packages
# WARN: need to be sure plugins are ok
ya pack -i

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
