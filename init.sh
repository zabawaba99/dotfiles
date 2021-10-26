#!/bin/bash

source bash/colors.zsh

if [ -e ~/.initialized ]; then
  # we have already initialized this machine, do nothing
  return 0
fi

if ! command -v brew >/dev/null; then
  p_white "Starting homebrew installation"

  xcode-select --install
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# go
# =========================
p_white "Starting go installation"
brew install go
mkdir ~/go
p_green "Go install complete"

# docker
# =========================
p_white "Starting docker installation"

brew cask install docker
brew install docker docker-compose
p_green "Docker install complete"

# aws
# =========================
p_white "Starting aws installation"
brew install awscli
p_green "aws install complete"

# mac apps
# =========================
p_white "Installing all the goodies"
storage=()
comm=(slack)
ides=(visual-studio-code)
tools=(iterm2)
goodies=()
apps=("${storage[@]}" "${comm[@]}" "${ides[@]}" "${tools[@]}" "${goodies[@]}")
for app in "${apps[@]}"; do
  brew install --cask $app >/dev/null
done
p_green "Mac apps install complete"

# git setup
p_white "Setting git up"
ln -s ~/dotfiles/git/config ~/.gitconfig
ln -s ~/dotfiles/git/global_ignore ~/.gitignore_global

brew install git
p_green "Git setup"

p_white "Installing some last minute apps"
brew install jq
p_green ":+1:"

# zsh
# =========================

p_white "Installing zsh"
brew install zsh zsh-completions zsh-syntax-highlighting

p_cyan "You need to add /usr/local/bin/zsh to /etc/shells."
p_cyan "Afterward run 'chsh -s $(which zsh)'"

# =========================
# setup rc file

ln -s ~/dotfiles/zshrc ~/.zshrc
touch ~/.initialized
