#!/bin/bash

source bash/colors.zsh

if [ -e ~/.initialized ]; then
  # we have already initialized this machine, do nothing
  return 0
fi

if ! command -v brew >/dev/null; then
  p_white "Starting homebrew installation"

  xcode-select --install
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# mac app installer
p_white "Getting the tap ready"
brew update
brew install caskroom/cask/brew-cask

# ruby
# =========================
p_white "Starting ruby installation"

brew install rbenv ruby-build
rbenv install 2.2.2
rbenv global 2.2.2
rbenv rehash

p_blue "installing some gems"
gems=(bundler pry awesome_print)
for gem in "${gems[@]}"; do
  gem install $gem >/dev/null
done
mkdir ~/ruby
p_green "Ruby install complete"

# go
# =========================
p_white "Starting go installation"
brew install go --with-cc-all
mkdir ~/go
p_green "Go install complete"

# docker
# =========================
p_white "Starting docker installation"

brew cask install dockertoolbox
docker-machine create --virtualbox-disk-size "40000" -d virtualbox dev
p_green "Docker install complete"

# npm
# =========================
p_white "Starting node installation"
brew install npm
npm install -g grunt
p_green "Node install complete"

# java
# =========================
p_white "Starting java installation"
# java version management
brew install jenv

brew cask install caskroom/versions/java6 caskroom/versions/java7 java

p_yellow "linking java version"
javas=(/Library/Java/JavaVirtualMachines/*)
for j in "${javas[@]}"; do
  jenv add $j/Contents/Home
done

brew install maven gradle
mkdir ~/java
p_green "Java install complete"

# android
# ========================
p_white "Starting android installation"
brew install android-sdk

packages=$(android list sdk | grep "Packages available for installation or update" | awk '{print $NF}')
android update sdk -u -a -t $(seq -s, -t$'\b' 1 $packages)
p_green "Android install complete"

# mac apps
# =========================
p_white "Installing all the goodies"
storage=(google-drive dropbox copy)
comm=(skype slack)
ides=(atom intellij-idea sublime-text)
tools=(google-chrome istat-menus 1password sourcetree iterm2)
goodies=(spotify reggy caffeine firefox mysqlworkbench evernote)
apps=("${storage[@]}" "${comm[@]}" "${ides[@]}" "${tools[@]}" "${goodies[@]}")
for app in "${apps[@]}"; do
  brew cask install $app >/dev/null
done
p_green "Mac apps install complete"

# git setup
p_white "Setting git up"
ln -s ~/dotfiles/git/config ~/.gitconfig
ln -s ~/dotfiles/git/global_ingore ~/.gitignore_global

brew install git
p_green "Git setup"

p_white "Installing some last minute apps"
brew install parallel aws-elasticbeanstalk hub jq redis mysql mongodb
p_green ":+1:"

# zsh
# =========================

p_white "Installing zsh"
brew install zsh zsh-completions zsh-syntax-highlighting

p_cyan "You need to add /usr/local/bin/zsh to /etc/shells."
p_cyan "Afterward run 'chsh -s $(which zsh)''"

# =========================
# setup rc file

ln -s ~/dotfiles/zshrc ~/.zshrc
touch ~/.initialized
