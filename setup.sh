#!/bin/bash
MY_PATH="`dirname \"$0\"`"
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"

echo "symlinking .bashrc..."
ln -sf $MY_PATH/.bashrc ~/.bashrc

echo "symlinking .bash_aliases..."
ln -sf $MY_PATH/.bash_aliases ~/.bash_aliases

echo "symlinking .inputrc..."
ln -sf $MY_PATH/.inputrc ~/.inputrc

echo "symlinking .vimrc..."
ln -sf $MY_PATH/.vimrc ~/.vimrc

echo "symlinking .spacemacs..."
ln -sf $MY_PATH/.spacemacs ~/.spacemacs

echo "symlinking .tmux.conf..."
ln -sf $MY_PATH/.tmux.conf ~/.tmux.conf

OS=$(uname -s)
if [[ $OS == "Darwin" ]]; then
    echo "symlinking .bash_profile on macOS"
    ln -sf $MY_PATH/.bash_profile ~/.bash_profile
    source ~/.bash_profile
else
    echo "skipping .bash_profile: not on macOS"

fi

# reload some dotfiles; others are only loaded on program init
#source ~/.bashrc
#bind -f ~/.inputrc
