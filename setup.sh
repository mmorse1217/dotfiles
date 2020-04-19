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
#ln -sf $MY_PATH/.bashrc ~/.bashrc
link_dotfile .bashrc 

echo "symlinking .bash_aliases..."
#ln -sf $MY_PATH/.bash_aliases ~/.bash_aliases
link_dotfile .bash_aliases

echo "symlinking .inputrc..."
#ln -sf $MY_PATH/.inputrc ~/.inputrc
link_dotfile .inputrc

echo "symlinking .vimrc..."
#ln -sf $MY_PATH/.vimrc ~/.vimrc
link_dotfile  .vimrc

echo "symlinking .spacemacs..."
#ln -sf $MY_PATH/.spacemacs ~/.spacemacs
link_dotfile .spacemacs

echo "symlinking .tmux.conf..."
#ln -sf $MY_PATH/.tmux.conf ~/.tmux.conf
link_dotfile .tmux.conf 

OS=$(uname -s)
if [[ $OS == "Darwin" ]]; then
    echo "symlinking .bash_profile on macOS"
    #ln -sf $MY_PATH/.bash_profile ~/.bash_profile
    link_dotfile  .bash_profile
    source ~/.bash_profile
else
    echo "skipping .bash_profile: not on macOS"

fi
#if [[ $OS == "Linux" ]]; then
#    link_dotfile .xinitrc
#    link_dotfile .Xmodmap
#else 
#    echo "skipping remapping of keybindings: not on linux"
#fi
# reload some dotfiles; others are only loaded on program init
#source ~/.bashrc
#bind -f ~/.inputrc
