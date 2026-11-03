#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
. "$HOME/.cargo/env"
alias so="bluetoothctl connect 18:9C:2C:3E:34:72"
export PATH="$HOME/.npm-global/bin:$PATH"
