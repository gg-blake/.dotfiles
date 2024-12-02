# Install Nix Package Manager
curl -L https://nixos.org/nix/install | sh

# Source Nix
. ~/.nix-profile/etc/profile.d/nix.sh

# Install Packages
nix-env -iA \
    nixpkgs.neovim \
    nixpkgs.tmux \
    nixpkgs.git \
    nixpkgs.conda \
    nixpkgs.zsh \
    nixpkgs.stow \
    nixpkgs.antibody

# Stow all Packages
stow git
stow zsh
stow nvim

# Add ZSH to valid login shells
command -v zsh | sudo tee -a /etc/shells

# Use ZSH as default shell
sudo chsh -s $(which zsh) $USER

#  Bundle ZSH plugins
antibody bundle <~/.zsh_plugins.txt >~/.zsh_plugins.sh

# Install Neovim plugins
nvim --headless "+Lazy! update" +q!
