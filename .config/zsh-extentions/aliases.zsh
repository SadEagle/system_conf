# Program aliases
alias nv='nvim'
alias icat='kitten icat'
alias rn='ranger'
alias lg='lazygit'
# TODO: make alias as snippe mkdir -p and cd
# alias mc=

# Alises dirs stack
alias d='dirs -v'
for index ({1..${DIRSTACKSIZE}}) alias "d$index"="cd +${index}"; unset index

# Directory aliases
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
