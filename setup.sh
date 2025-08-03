#!/bin/bash
set -e

OS=$(uname -s)

if [[ "$OS" == "Darwin" ]]; then
  echo "🍏 Detected macOS"

  # Check for Xcode Command Line Tools
  if ! xcode-select -p &>/dev/null; then
    echo "📦 Installing Xcode Command Line Tools..."
    xcode-select --install

    # Wait until installed
    until xcode-select -p &>/dev/null; do
      sleep 5
    done
  fi

elif [[ "$OS" == "Linux" ]]; then
  echo "🐧 Detected Linux"
  # Add Linux-specific setup here if needed

else
  echo "❌ Unsupported OS: $OS"
  exit 1
fi

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Update & upgrade
brew update && brew upgrade

# Core packages
xargs brew install < brew_pkgs.txt

# Stow .dotfiles
cd ~/.dotfiles
stow \
    config \
    zsh \
    vscode

# Set Zsh as default shell
if [ "$SHELL" != "/bin/zsh" ]; then
    echo "🔁 Setting Zsh as default shell..."
    chsh -s /bin/zsh
fi

# Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "💅 Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "✅ Setup complete!"
