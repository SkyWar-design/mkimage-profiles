# ~/.bashrc
# The individual per-interactive-shell startup file.

# Source global definitions.
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Define user specific aliases and functions.
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias d='ls'
alias s='cd ..'
alias p='cd -'

# Read /etc/inputrc if the variable is not defined.
[ -n "$INPUTRC" ] || export INPUTRC=/etc/inputrc

ENV=$HOME/.bashrc
USERNAME="root"
export USERNAME ENV

# Запуск atomic-installer при старте
if [ -n "$PS1" ]; then
    echo "Запуск atomic-actions ..."
    atomic-actions install-system
fi