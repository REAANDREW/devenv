#!/usr/bin/env bash
declare -A osInfo;
osInfo[/etc/redhat-release]=yum
osInfo[/etc/arch-release]=pacman
osInfo[/etc/gentoo-release]=emerge
osInfo[/etc/SuSE-release]=zypp
osInfo[/etc/debian_version]=apt-get

for f in ${!osInfo[@]}
do
    if [[ -f $f ]];then
        echo Package manager: ${osInfo[$f]}
        PM=${osInfo[$f]}
    fi
done

if [ -d /home/vagrant ]; then
  echo "Treating current user as vagrant"
  USER=vagrant
else
  echo "You are running this script as root on a non-vagrant box (you shouldn't)."
  echo "Please try again as the user you wish to install as."
  exit 2
fi

echo "Installing required packages"
sudo $PM update
sudo $PM install -y vim
sudo $PM install -y git-core
sudo $PM install -y curl
sudo $PM install -y tmux
sudo $PM install -y cmake
sudo $PM install -y automake
sudo $PM install -y exuberant-ctags
sudo $PM install -y tmux
sudo $PM install -y cmake
sudo $PM install -y make
sudo $PM install -y build-essential
sudo $PM install -y gdb

echo "Creating VIM mods"
mkdir -p /home/$USER/.vim/autoload /home/$USER/.vim/bundle; \
curl -LSso /home/$USER/.vim/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

echo "Creating VIM bundles"
rm -rf /home/$USER/.vim/bundle/*
git clone https://github.com/scrooloose/nerdtree.git /home/$USER/.vim/bundle/nerdtree
git clone https://github.com/Chiel92/vim-autoformat.git /home/$USER/.vim/bundle/vim-autoformat
git clone https://github.com/nanotech/jellybeans.vim /home/$USER/.vim/bundle/jellybeans
git clone https://github.com/geekjuice/vim-spec.git /home/$USER/.vim/bundle/vim-spec
git clone https://github.com/majutsushi/tagbar.git /home/$USER/.vim/bundle/tarbar
git clone https://github.com/tomtom/tlib_vim.git /home/$USER/.vim/bundle/tlib_vim
git clone https://github.com/MarcWeber/vim-addon-mw-utils.git /home/$USER/.vim/bundle/vim-addon-mw-utils
git clone https://github.com/garbas/vim-snipmate.git /home/$USER/.vim/bundle/vim-snipmate
git clone https://github.com/honza/vim-snippets.git /home/$USER/.vim/bundle/vim-snippets
git clone https://github.com/majutsushi/tagbar /home/vagrant/.vim/bundle/tagbar

ln -s $PWD/.vimrc /home/$USER/.vimrc
ln -s $PWD/.gemrc /home/$USER/.gemrc
ln -s $PWD/.tmux.conf /home/$USER/.tmux.conf

echo "Installing NVM"
git clone https://github.com/creationix/nvm.git /home/$USER/.nvm/
echo "source /home/$USER/.nvm/nvm.sh" >> /home/$USER/.bashrc
source /home/$USER/.nvm/nvm.sh 

echo "Installing node.js v0.10"
nvm install 0.10
echo "nvm use 0.10" >> /home/$USER/.bashrc

# Ruby not playing ball at the moment
# echo "Installing RVM and Ruby"
# \curl -sSL https://get.rvm.io | bash -s stable --ruby

echo "Creating Symlinks"
chown -R $USER:$USER /home/$USER/.nvm/
chown -R $USER:$USER /home/$USER/.vim/
chown $USER:$USER /home/$USER/.vimrc

echo "Installing node modules"
npm install --loglevel error -g nodemon
npm install --loglevel error -g mocha
npm install --loglevel error -g grunt-cli
npm install --loglevel error -g js-beautify
npm install --loglevel error -g grunt-init

echo "Installing grunt-init-node"
git clone https://github.com/gruntjs/grunt-init-node.git /home/$USER/.grunt-init/node
chown -R $UUSER:$USER /home/$USER/.grunt-init/

echo "Installing tmux cpu-mem"
git clone https://github.com/thewtex/tmux-mem-cpu-load.git /tmp/tmux
cd /tmp/tmux
cmake .
make
sudo make install

echo "Installing git-flow"
cd /tmp
sudo curl -O https://raw.githubusercontent.com/nvie/gitflow/develop/contrib/gitflow-installer.sh
sudo chmod +x /tmp/gitflow-installer.sh
sudo /tmp/gitflow-installer.sh

echo "Done!"
echo "Your vagrant development environment is ready to use"
