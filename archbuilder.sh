#!/bin/bash

# Function to display the menu
show_menu() {
    echo "Select an Option:"
    echo "1) Setup Xorg"
    echo "2) Setup Nvidia GPU drivers"
    echo "3) Setup Pipewire/Wireplumber"
    echo "4) Configure Networking"
    echo "5) Configure Dbus"
    echo "6) Configure Plugdev"
    echo "7) Setup Docker"
    echo "8) Setup Gnome Shell"
    echo "9) Setup KDE Plasma 5"
    echo "10) Setup Flatpak"
    echo "11) Setup NixOS package manager"
    echo "12) Setup Derrik's packages"
    echo "13) Setup Derrik's Flatpak packages"
    echo "14) Update Arch Linux"
    echo "15) Setup Tailscale"
    echo "16) Install Trizen (AUR helper)"
    echo "17) Exit"
}

# Function to execute the selected command
execute_command() {
    case $choice in
        1)
            sudo pacman -Syu xorg
            echo "Setting up Xorg..."
            ;;
        2)
            sudo pacman -Syu nvidia nvidia-utils nvidia-settings
            echo "Setting up Nvidia drivers..."
            ;;
        3)
            sudo pacman -Syu pipewire wireplumber pipewire-pulse pipewire-alsa
            echo "Setting up Pipewire..."
            ;;
        4)
            sudo pacman -Syu networkmanager
            sudo systemctl enable NetworkManager.service
            sudo systemctl start NetworkManager.service
            echo "Configuring Network Manager..."
            ;;
        5)
            sudo pacman -Syu dbus
            sudo systemctl enable dbus
            sudo systemctl start dbus
            echo "Configuring Dbus..."
            ;;
        6)
            sudo groupadd plugdev
            sudo usermod -aG plugdev $USER
            echo "Configuring Plugdev..."
            ;;
        7)
            sudo pacman -Syu docker
            sudo systemctl enable docker
            sudo systemctl start docker
            sudo usermod -aG docker $USER
            echo "Setting up Docker..."
            ;;
        8)
            sudo pacman -Syu gnome gnome-extra
            sudo systemctl enable gdm
            sudo systemctl start gdm
            echo "Setting up Gnome Shell..."
            ;;
        9)
            sudo pacman -Syu plasma kde-applications sddm
            sudo systemctl enable sddm
            sudo systemctl start sddm
            echo "Setting up KDE Plasma 5..."
            ;;
        10)
            sudo pacman -Syu flatpak
            sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
            echo "Setting up Flatpak..."
            ;;
        11)
            sudo sh <(curl -L https://nixos.org/nix/install) --daemon
            echo "Setting up Nix package manager..."
            ;;
        12)
            sudo pacman -Syu gimp tailscale vlc nano firefox thunderbird git papirus-icon-theme geany distrobox wine fish util-linux pciutils usbutils coreutils binutils findutils grep iproute2 bash bash-completion udisks2 base-devel cmake
            echo "Setting up Derrik's packages..."
            ;;
        13)
            flatpak install flathub com.mattjakeman.ExtensionManager com.discordapp.Discord io.kopia.KopiaUI com.spotify.Client com.valvesoftware.Steam org.telegram.desktop tv.plex.PlexDesktop com.nextcloud.desktopclient.nextcloud im.riot.Riot -y
            echo "Setting up Derrik's Flatpak packages..."
            ;;
        14)
            sudo pacman -Syu
            echo "Updating Arch Linux..."
            ;;
        15)
            sudo pacman -Syu tailscale
            sudo systemctl enable --now tailscaled
            sudo tailscale up -qr
            echo "Configuring Tailscale..."
            ;;
        16)
            git clone https://aur.archlinux.org/trizen.git
            cd trizen
            makepkg -sri
            cd ..
            echo "Installing Trizen..."
            ;;
        17)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid selection. Please try again."
            ;;
    esac
}

# Main loop to display the menu and execute commands
while true; do
    show_menu
    read -rp "Enter your choice: " choice
    execute_command
done
