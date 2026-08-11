#!/usr/bin/env bash
set -e

sudo apt update
sudo apt install -y \
    git make unzip ripgrep fd-find \
    lua-language-server stylua ruff prettierd shfmt \
    clang-format rustfmt cargo \
    nil nixpkgs-fmt bash-language-server \
    shellcheck luarocks luacheck \
    nodejs npm python3 python3-pip \
    wl-clipboard xclip

sudo npm install -g prettierd

pip3 install --user ruff

echo "All dependencies installed"
chmod +x ~/.config/nvim/scripts/install.sh
