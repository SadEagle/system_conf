# Most useful and needed system setup

# Install yay
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..; rm -rf yay

# Enable multilib
sudo sed -i "/\[multilib\]/,/Include/"'s/^#//'
# Update 
yay -Suy

# System packages
# WARN: include not all packages need update after fresh install
yay -S networkmanager
yay -S pipewire pipewire-alsa lib32-pipewire pipewire-pulse
yay -S nvidia

# Enviroment packages
yay -S kitty hyprland hyprshot btop 
yay -S waybar rofi-wayland lutris telegram-desktop transmission-qt
# Lutris wine
# https://github.com/lutris/docs/blob/master/WineDependencies.md
sudo pacman -S wine-staging
sudo pacman -S --needed --asdeps giflib lib32-giflib gnutls lib32-gnutls v4l-utils lib32-v4l-utils libpulse \
lib32-libpulse alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib sqlite lib32-sqlite libxcomposite \
lib32-libxcomposite ocl-icd lib32-ocl-icd libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs \
lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader sdl2 lib32-sdl2
# AUR
yay -S joplin-desktop 
yay -S nekoray sing-geoip-db sing-geosite-db
yay -S pwvucontrol

# Main work packages
yay -S zsh nvim fd fzf ripgrep zoxide yazi
# Extent work packages 
yay -S bat

# Make zsh default shell
chsh --shell /bin/zsh

# Install yazi packages
ya pack -i

# Firefox and it's custom profile
yay -S firefox tridactyl
# Set firefox default profile
# WARN: not sure if okay, need clean install test
PROFILE_NAME="zndrsg72.sandy"
DEFAULT_FIREFOX_PATH="$HOME/.mozilla/firefox"
firefox -CreateProfile "$PROFILE_NAME"
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
