#!/bin/sh

USER=`whoami`

HMDR=/home/$USER
CURDR=`pwd`

cd $HMDR
ln -s .vim/.vimrc .vimrc

cd $HMDR/.vim

git submodule init
git submodule update

mkdir ~/.fonts/
git clone https://github.com/scotu/ubuntu-mono-powerline.git ~/.fonts/ubuntu-mono-powerline 

cd $CURDR
