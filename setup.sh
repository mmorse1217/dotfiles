#!/bin/bash

function linkDotfile {
    dest="${HOME}/${1}"
    dateStr=$(date +%Y-%m-%d-%H%M)

    if [ -h ~/${1} ]; then
        # Existing symlink 
        echo "Removing existing symlink: ${dest}"
        rm ${dest} 

    elif [ -f "${dest}" ]; then
        # Existing file
        echo "Backing up existing file: ${dest}"
        mv ${dest}{,.${dateStr}}

    elif [ -d "${dest}" ]; then
        # Existing dir
        echo "Backing up
        existing dir: ${dest}"
        mv
        ${dest}{,.${dateStr}}
    fi

    echo "Creating
    new symlink:
    ${dest}"
    ln -s
    ${dotfilesDir}/${1}
    ${dest}
}

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
source ~/.bashrc
bind -f ~/.inputrc
