#! /bin/bash

sudo pacman -Sc --noconfirm
yay -Sc --noconfirm
sudo pacman -Rns $(pacman -Qtdq) --noconfirm
sudo pacman-mirrors --fasttrack 10 && sudo pacman -Syyu --noconfirm
