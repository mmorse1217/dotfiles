#!/bin/bash

MY_PATH="`dirname \"$0\"`"
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"

function link_dotfile {
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
        echo "Backing up existing dir: ${dest}"
        mv ${dest}{,.${dateStr}}
    fi

    echo "Creating new symlink: ${dest}"
    ln -s ${MY_PATH}/${1} ${dest}
}



echo "symlinking .bashrc..."
link_dotfile .bashrc 

echo "symlinking .bash_aliases..."
link_dotfile .bash_aliases

echo "symlinking .inputrc..."
link_dotfile .inputrc

echo "symlinking .vimrc..."
link_dotfile  .vimrc

echo "symlinking .spacemacs..."
link_dotfile .spacemacs

echo "symlinking .tmux.conf..."
link_dotfile .tmux.conf 

echo "symlinking .vim/coc-settings.json..."
link_dotfile .vim/coc-settings.json 

OS=$(uname -s)
if [[ $OS == "Darwin" ]]; then
    echo "symlinking .bash_profile on macOS"
    link_dotfile  .bash_profile
    source ~/.bash_profile
else
    echo "skipping .bash_profile: not on macOS"

fi



# reload some dotfiles; others are only loaded on program init
#source ~/.bashrc
#bind -f ~/.inputrc
