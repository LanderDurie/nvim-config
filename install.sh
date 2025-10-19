#!/usr/bin/env bash
set -e

# -----------------------------------------------------------------------------
# Configuration
# -----------------------------------------------------------------------------
MIN_NVIM_VERSION="0.9.0"
NVIM_REPO="https://github.com/neovim/neovim.git"
BUILD_DIR="$HOME/.local/src"
INSTALL_PREFIX="/usr/local"

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config/nvim"
SOURCE_DIR="$REPO_DIR/nvim"

# -----------------------------------------------------------------------------
# Helper: compare versions (semver)
# -----------------------------------------------------------------------------
version_ge() {
    # returns 0 if $1 >= $2
    [ "$(printf '%s\n' "$2" "$1" | sort -V | head -n1)" = "$2" ]
}

# -----------------------------------------------------------------------------
# Step 1: Ensure Neovim meets minimum version
# -----------------------------------------------------------------------------
install_nvim_if_needed() {
    echo ">>> Checking Neovim installation..."

    if command -v nvim >/dev/null 2>&1; then
        NVIM_VERSION=$(nvim --version | head -n1 | awk '{print $2}')
        echo ">>> Found Neovim version $NVIM_VERSION"

        if version_ge "$NVIM_VERSION" "$MIN_NVIM_VERSION"; then
            echo ">>> Neovim version is sufficient."
            return
        else
            echo ">>> Neovim is too old (need >= $MIN_NVIM_VERSION)."
        fi
    else
        echo ">>> Neovim not found."
    fi

    echo ">>> Installing/Updating Neovim from source..."
    mkdir -p "$BUILD_DIR"
    cd "$BUILD_DIR"

    if [ -d neovim ]; then
        cd neovim
        git fetch origin
        git checkout stable
        git pull
    else
        git clone --depth 1 --branch stable "$NVIM_REPO"
        cd neovim
    fi

    make CMAKE_BUILD_TYPE=Release
    sudo make install

    echo ">>> Neovim successfully installed to $INSTALL_PREFIX/bin/nvim"
}

# -----------------------------------------------------------------------------
# Step 2: Install config (your existing logic)
# -----------------------------------------------------------------------------
install_config() {
    echo ">>> Installing Neovim config from $SOURCE_DIR"

    if [ -d "$CONFIG_DIR" ] && [ ! -L "$CONFIG_DIR" ]; then
        BACKUP_DIR="$HOME/.config/nvim_backup_$(date +%Y%m%d_%H%M%S)"
        echo ">>> Backing up existing config to $BACKUP_DIR"
        mv "$CONFIG_DIR" "$BACKUP_DIR"
    fi

    if [ -L "$CONFIG_DIR" ]; then
        echo ">>> Removing existing symlink"
        rm "$CONFIG_DIR"
    fi

    echo ">>> Linking $SOURCE_DIR -> $CONFIG_DIR"
    ln -s "$SOURCE_DIR" "$CONFIG_DIR"

    echo ">>> Config installed. Run 'nvim' to complete setup."
}

# -----------------------------------------------------------------------------
# Main Script
# -----------------------------------------------------------------------------
install_nvim_if_needed
install_config

