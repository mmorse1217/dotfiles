#!/bin/bash

if ! command -v stow &> /dev/null
then
	sudo apt update
	sudo apt install -y stow --no-install-recommends
	rm -rf /var/lib/apt/lists/*
fi

STOW_ARGS="-vv"
echo $STOW_ARGS
stow ${STOW_ARGS} -t ~ bash 
stow ${STOW_ARGS} -t ~ vim
stow ${STOW_ARGS} -t ~ emacs
stow ${STOW_ARGS} -t ~ tmux
stow ${STOW_ARGS} -t ~ keybindings
