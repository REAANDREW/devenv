!/usr/bin/env bash

apt-get update
apt-get install -y vim
apt-get install -y git-core
apt-get install -y curl

mkdir -p /home/vagrant/.vim/autoload ~/.vim/bundle; \
curl -LSso /home/vagrant/.vim/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

git clone https://github.com/scrooloose/nerdtree.git /home/vagrant/.vim/bundle/nerdtree

cp /vagrant/.vimrc /home/vagrant/.vimrc
