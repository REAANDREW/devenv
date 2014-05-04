!/usr/bin/env bash

apt-get update
apt-get install -y vim
apt-get install -y git-core
apt-get install -y curl

mkdir -p /home/vagrant/.vim/autoload /home/vagrant/.vim/bundle; \
curl -LSso /home/vagrant/.vim/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

rm -rf /home/vagrant/.vim/bundle/*
git clone https://github.com/scrooloose/nerdtree.git /home/vagrant/.vim/bundle/nerdtree
git clone https://github.com/Chiel92/vim-autoformat.git /home/vagrant/.vim/bundle/vim-autoformat
git clone https://github.com/nanotech/jellybeans.vim /home/vagrant/.vim/bundle/jellybeans
git clone https://github.com/geekjuice/vim-spec.git /home/vagrant/.vim/bundle/vim-spec

cp /vagrant/.vimrc /home/vagrant/.vimrc

git clone https://github.com/creationix/nvm.git /home/vagrant/.nvm/

echo "source /home/vagrant/.nvm/nvm.sh" >> /home/vagrant/.bashrc
echo $USER

source /home/vagrant/.nvm/nvm.sh 
echo $nvmc >> /home/vagrant/.bashrc
$nvmc

nvm install 0.10
echo "nvm use 0.10" >> /home/vagrant/.bashrc

chown -R vagrant:vagrant /home/vagrant/.nvm/
chown -R vagrant:vagrant /home/vagrant/.vim/
chown vagrant:vagrant /home/vagrant/.vimrc

npm install -g nodemon
npm install -g mocha
npm install -g grunt-cli
npm install -g js-beautify
