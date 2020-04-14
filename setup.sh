#!/bin/bash
echo "symlinking .bashrc..."
ln -sf `pwd`/.bashrc ~/.bashrc

echo "symlinking .bash_aliases..."
ln -sf `pwd`/.bash_aliases ~/.bash_aliases

echo "symlinking .inputrc..."
ln -sf `pwd`/.inputrc ~/.inputrc

echo "symlinking .vimrc..."
ln -sf `pwd`/.vimrc ~/.vimrc

echo "symlinking .spacemacs..."
ln -sf `pwd`/.spacemacs ~/.spacemacs

echo "symlinking .tmux.conf..."
ln -sf `pwd`/.tmux.conf ~/.tmux.conf

OS=$(uname -s)
if [[ $OS == "Darwin" ]]; then
    echo "symlinking .bash_profile on macOS"
    ln -sf `pwd`/.bash_profile ~/.bash_profile
    source ~/.bash_profile
else
    echo "skipping .bash_profile: not on macOS"

fi

# reload some dotfiles; others are only loaded on program init
#source ~/.bashrc
#bind -f ~/.inputrc
