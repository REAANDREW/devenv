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
sudo $PM install -y git-core
sudo $PM install -y mercurial
sudo $PM install -y checkinstall
sudo $PM install -y libncurses5-dev
sudo $PM install -y python-dev
sudo $PM install -y unzip

#Install vim with python support
cd ~
hg clone https://vim.googlecode.com/hg/ vim
pushd vim
./configure --with-features=huge \
  --enable-multibyte \
  --enable-pythoninterp \
  --with-python-config-dir=/usr/lib/python2.7/config \
  --enable-cscope --prefix=/usr

make VIMRUNTIMEDIR=/usr/share/vim/vim74
sudo checkinstall -y
popd

#Remove the source files
rm -r vim/

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
sudo $PM install -y python-pip

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
