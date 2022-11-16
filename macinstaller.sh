#!/usr/bin/env bash
#
echo "Starting installer..."

if test ! $(which brew); then
    echo "Homebrew not found. Installing..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update && brew upgrade

brew install $(~/homebrew.rtf)


echo "Installing Oh-My-Zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing powerlevel10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "Downloading dotfiles"
git clone https://github.com/robifis/bob_dotfiles.git
cd bob_dotfliles
sudo cp * ~/
cd ..

sudo chsh -S $(which zsh)
chsh -S $(which zsh)

source .zsh 
source .vimrc

brew update && brew upgrade && brew doctor
brew cleanup



echo "General optimisations...:"
xcode-select —install
defaults write com.apple.dock autohide-delay -float 0; defaults write com.apple.dock autohide-time-modifier -int 0;killall Dock
defaults write com.apple.Dock showhidden -bool TRUE && killall Dock
defaults write com.apple.dock static-only -bool TRUE; killall Dock
defaults write com.apple.dock autohide-time-modifier -float 1; killall Dock
defaults write com.apple.finder AppleShowAllFiles TRUE
defaults write com.apple.dashboard mcx-disabled -boolean TRUE killall Dock
sudo sysctl debug.lowpri_throttle_enabled=0
defaults write com.apple.dock launchanim -bool false
sudo defaults write /Library/Preferences/com.apple.loginwindow DesktopPicture ""

echo "Checking for software updates..."
softwareupdate -i -a

# FINALLY DOING A REBOOT
echo "Doing a reboot..."
sudo shutdown -r now



