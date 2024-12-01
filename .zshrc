autoload -Uz vcs_info compinit &&
                        compinit
precmd() { vcs_info }

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST                 # Enable external variables inside prompt (vcs_info_msg_0_)
# PROMPT='%F{green}%\%n %F{yellow}%\- %F{blue}%\%~ %F{cyan}%\\${vcs_info_msg_0_} %F{white}%\\> '
PROMPT='%F{green}%\%n %F{blue}%\%~ %F{cyan}%\\${vcs_info_msg_0_} %F{white}%\\> '

# History settings
setopt HIST_IGNORE_DUPS             # Dont include duplicate the previous command
export HISTSIZE=10000               # Maximum events for internal history
export SAVEHIST=10000               # Maximum events in history file

# Don't store in history incorrect cmd, enable watch previous cmd even if wrong
# Check first non-assigment text as command (DEBUG=1 ./some_prog)
# https://superuser.com/questions/902241/how-to-make-zsh-not-store-failed-command
 zshaddhistory() {
   local j=1
   while ([[ ${${(z)1}[$j]} == *=* ]]) {
     ((j++))
   }
   whence ${${(z)1}[$j]} >| /dev/null || return 1
 }

# Push stack setting
setopt AUTO_PUSHD                   # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS            # Do not store duplicates in the stack.
setopt PUSHD_SILENT                 # Do not print the directory stack after pushd or popd.
setopt INC_APPEND_HISTORY_TIME      # Store commands at use time when terminal close (against rewrite by default)

alias d='dirs -v'
dirstacksize=12
for index ({1..${dirstacksize}}) alias "d$index"="cd +${index}"; unset index

# Autocomplete
setopt AUTO_MENU        # 1st tab create menu; 2nd go throught it

# Extra modification files
ZSH_EXT="$HOME/zsh-extentions"
source "$ZSH_EXT/aliases.zsh"

# Styling
zstyle ':vcs_info:git:*' formats '[%b]'         # format the vcs_info_msg_0_ variable
zstyle ':completion:*' menu select
zstyle ':completion:*' file-sort change         # Sort by last change
# Case-insensitive completion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Base keybinds
# Enable vim (mostly useless)
bindkey -v 
# Vim analogy history search
bindkey "^P" history-beginning-search-backward
bindkey "^N" history-beginning-search-forward
# Delete left/right part of text respectively coursor
bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word

# ZPLUG Module
source ~/.zplug/init.zsh

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

# Bind keys plugins
# Autosuggestion
ZSH_AUTOSUGGEST_STRATEGY=(history completion)       # Autocompletion search order 
bindkey "\ek" autosuggest-accept        # Accept
bindkey "\ej" autosuggest-execute       # Accept and run
bindkey "\el" forward-word              # Accept word by word
bindkey "\ec" autosuggest-clear         # Clear suggestion
bindkey "\ex" autosuggest-toggle        # Enable/disable suggestion

