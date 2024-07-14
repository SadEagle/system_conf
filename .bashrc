#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Custom aliases
alias nv='nvim'
alias ..='cd ..'

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='\033[01;32m\]\u\[\033[1;37m\]\w\[\033[00m\]\$ '
