#!/usr/bin/env sh

# Go should have been installed by now
# if install.conf.yaml has been configured correctly

SOURCE_PATH="/usr/local/src"
INSTALL_PATH="/usr/local/bin"

GO_PATH=$(which go 2> /dev/null)

if [[ $GO_PATH == "" ]]; then
    echo "Go is not installed. Installing now..."
    sudo pacman -S go --noconfirm
fi

cd $SOURCE_PATH
rm -rf $SOURCE_PATH/nerd-ls
git clone https://github.com/jorismertz/nerd-ls; cd nerd-ls
go build .
chmod +x ./nerd-ls
sudo rm -rf $INSTALL_PATH/nerd-ls
sudo ln -s $(pwd)/nerd-ls $INSTALL_PATH/nerd-ls
