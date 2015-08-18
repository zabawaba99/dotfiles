#!/bin/bash

if [ -e ~/.initialized ]; then
  # we have already initialized this machine, do nothing
  return 0
fi

function rp() {
  p=$1
  shift

  p_yellow "$p"
  eval $@
  p_green "Finished $p"
}


if ! command -v brew >/dev/null; then
  p_white "Starting homebrew installation"

  # prereq 'xcode-select'
  rp "installing xcode-select..."  xcode-select --install

  rp "installing hombrew..." ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# mac app installer
rp "installing caskroom" brew install caskroom/cask/brew-cask

# ruby
# =========================
p_white "Starting ruby installation"

rp "installing rbenv" brew install rbenv
rp "installing ruby 2.2.2" rbenv install 2.2.2
rbenv global 2.2.2
rbenv rehash

rp "installing some gems"
gems=(bundler pry awesome_print)
for gem in "${gems[@]}"; do
  gem install $gem >/dev/null
done

mkdir ~/ruby

# go
# =========================
p_white "Starting go installation"
rp "installing go" brew install go --with-cc-all
mkdir ~/go


# docker
# =========================
p_white "Starting docker installation"

rp "installing virtualbox" brew cask install dockertoolbox
rp "setting up docker vm" docker-machine create --virtualbox-disk-size "40000" -d virtualbox dev

# npm
# =========================
p_white "Starting node installation"
rp "installing node" brew install npm
npm install -g grunt

# java
# =========================
p_white "Starting java installation"
# java version management
rp "installing jenv" brew install jenv

rp "installing java6" brew cask install caskroom/versions/java6
rp "installing java7" brew cask install caskroom/versions/java7
rp "installing java8" brew cask install java

p_yellow "linking java version"
java_path="/Library/Java/JavaVirtualMachines"
ls $java_path | xargs -n1 jenv add $java_path/$1/Contents/Home

rp "installing maven" brew install maven
rp "installing gradle" brew install gradle

mkdir ~/java

# android
# ========================
p_white "Starting android installation"
rp "install android tools" brew android-sdk

packages=$(android list sdk | grep "Packages available for installation or update" | awk '{print $NF}')
android update sdk -u -a -t $(seq -s, -t$'\b' 1 $packages)


# mac apps
# =========================
storage=(google-drive dropbox copy)
comm=(skype slack)
ides=(atom intellij-idea sublime-text)
tools=(google-chrome istat-menus 1password sourcetree iterm2)
goodies=(spotify reggy caffeine firefox mysqlworkbench evernote)
apps=("${storage[@]}" "${comm[@]}" "${ides[@]}" "${tools[@]}" "${goodies[@]}")
for app in "${apps[@]}"; do
  brew cask install $app >/dev/null
done

# git setup
ln -s ~/dotfiles/git/config ~/.gitconfig
ln -s ~/dotfiles/git/global_ingore ~/.gitignore_global

rp "installing newer git version" brew install git

# shell utitlies
brew install parallel aws-elasticbeanstalk hub jq

# databases
brew install redis mysql mongodb

# zsh
# =========================

rp "installing zsh" brew install zsh zsh-completions zsh-history-substring-search zsh-syntax-highlighting
chsh -s $(which zsh)

# =========================
# setup rc file

ln -s ~/dotfiles/zshrc ~/.zshrc
touch ~/.initialized