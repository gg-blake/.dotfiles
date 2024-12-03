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
stow conda

# Add ZSH to valid login shells
command -v zsh | sudo tee -a /etc/shells

# Use ZSH as default shell
sudo chsh -s $(which zsh) $USER

#  Bundle ZSH plugins
antibody bundle <~/.zsh_plugins.txt >~/.zsh_plugins.sh

# Create all the envs from the repo
for i in ~/.dotfiles/conda_envs/*; do # iterate over all files in current dir
    if [ -f "$i" ]; then              # if it's a directory
        conda env create -f "$i"
    fi
done

# Add auto export script to all environments
for i in ~/miniconda3/envs/*; do # iterate over all files in current dir
    if [ -d "$i" ]; then         # if it's a directory
        mkdir -p "$i/etc/conda/deactivate.d"
        cp ~/.dotfiles/export_env.sh "$i/etc/conda/deactivate.d" # copy water.txt into it
        chmod +x "$i/etc/conda/deactivate.d/export_env.sh"
        mkdir -p "$i/etc/conda/activate.d"
        cp ~/.dotfiles/update_env.sh "$i/etc/conda/activate.d" # copy water.txt into it
        chmod +x "$i/etc/conda/activate.d/update_env.sh"
    fi
done

# Source ZSH plugins
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Install Neovim plugins
nvim --headless "+Lazy! update" +q!:
