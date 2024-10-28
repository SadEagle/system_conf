export ZSH="$HOME/.oh-my-zsh"

autoload -Uz compinit promptinit colors 
compinit
promptinit
colors

zstyle ':completion:*' menu select

# autoload -U colors && colors
PROMPT="%{$fg[green]%}%n %{$fg[yellow]%}- %{$fg[blue]%}%~ %{$fg[white]%}$ "

# Custom aliases
alias nv='nvim'
alias ..='cd ..'
alias icat='kitten icat'

plugins=(
    git
    aliases
)

source $ZSH/oh-my-zsh.sh

# ZPLUG Module
source ~/.zplug/init.zsh

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "jeffreytse/zsh-vi-mode"
# zplug "olivierverdier/zsh-git-prompt"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

bindkey -s '^[V'  autosuggest-accept
zplug load

# Plugins keybinds
# zsh-autosugestion
