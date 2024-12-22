# Program aliases
alias nv='nvim'
alias icat='kitten icat'
alias rn='ranger'
alias lg='lazygit'

# Alises dirs stack
alias d='dirs -v'
dirstacksize=12
for index ({1..${dirstacksize}}) alias "d$index"="cd +${index}"; unset index

# Directory aliases
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
