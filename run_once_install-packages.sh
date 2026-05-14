#!/usr/bin/env bash

set -euo pipefail

echo "Detecting distribution..."

if command -v pacman >/dev/null 2>&1; then
    DISTRO="arch"
elif command -v dnf >/dev/null 2>&1; then
    DISTRO="fedora"
elif command -v apt >/dev/null 2>&1; then
    DISTRO="debian"
else
    echo "Unsupported distribution"
    exit 1
fi

echo "Detected: $DISTRO"

COMMON_PACKAGES=(
    fish
    kitty
    starship
    chezmoi
    neovim
    fzf
    zoxide
    bat
    ripgrep
    tree
    nodejs
    npm
    htop
)

ARCH_ONLY=(
    pacman-contrib
    reflector
    wl-clipboard
)

install_arch() {
    sudo pacman -Sy --needed "${COMMON_PACKAGES[@]}" "${ARCH_ONLY[@]}"

    if ! command -v yay >/dev/null 2>&1; then
        echo "Installing yay..."

        sudo pacman -S --needed git base-devel

        tmpdir=$(mktemp -d)
        git clone https://aur.archlinux.org/yay.git "$tmpdir/yay"

        pushd "$tmpdir/yay"
        makepkg -si --noconfirm
        popd

        rm -rf "$tmpdir"
    fi
}

install_arch_fonts() {
    sudo pacman -S --needed ttf-hack

    # Nerd Font version (if not in repos, use AUR via yay)
    if ! pacman -Qi ttf-hack-nerd >/dev/null 2>&1; then
        yay -S --noconfirm ttf-hack-nerd
    fi
}

install_fedora() {
    sudo dnf install -y \
        fish \
        kitty \
        starship \
        chezmoi \
        neovim \
        fzf \
        zoxide \
        bat \
        ripgrep \
        tree \
        nodejs \
        npm \
        htop \
        wl-clipboard
}

install_fedora_fonts() {
    sudo dnf install -y hack-fonts
}

install_debian() {
    sudo apt update

    sudo apt install -y \
        fish \
        kitty \
        neovim \
        fzf \
        zoxide \
        bat \
        ripgrep \
        tree \
        nodejs \
        npm \
        htop \
        wl-clipboard \
        curl \
        git

    if ! command -v starship >/dev/null 2>&1; then
        curl -sS https://starship.rs/install.sh | sh
    fi

    if ! command -v chezmoi >/dev/null 2>&1; then
        sh -c "$(curl -fsLS get.chezmoi.io)"
    fi
}

install_debian_fonts() {
    mkdir -p ~/.local/share/fonts

    cd /tmp
    curl -fLo Hack.zip \
        https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip

    unzip -o Hack.zip -d ~/.local/share/fonts/

    fc-cache -fv
}

change_shell_to_fish() {
    if command -v fish >/dev/null 2>&1; then
        if [ "$SHELL" != "$(command -v fish)" ]; then
            echo "Changing default shell to fish..."
            chsh -s "$(command -v fish)"
        else
            echo "Fish already default shell."
        fi
    else
        echo "Fish not installed, skipping shell change."
    fi
}

case "$DISTRO" in
    arch)
        install_arch
        install_arch_fonts
        ;;
    fedora)
        install_fedora
        install_fedora_fonts
        ;;
    debian)
        install_debian
        install_debian_fonts
        ;;esac

change_shell_to_fish()

echo "Done."
