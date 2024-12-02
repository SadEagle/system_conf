autoload -Uz vcs_info compinit &&
                        compinit
precmd() { vcs_info }

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST                 # Enable external variables inside prompt (vcs_info_msg_0_)
PROMPT='%F{green}%\%n %F{blue}%\%~ %F{cyan}%\\${vcs_info_msg_0_} %F{white}%\\❭ '

# History settings
export HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS             # Dont include duplicate the previous command
setopt APPENDHISTORY                # Add terminal history (dont rewrite)
setopt HIST_EXPIRE_DUPS_FIRST       # If HISTSIZE > SAVEHIST, then cut duplicates cmds to put more original commands
setopt INC_APPEND_HISTORY_TIME      # Store commands at use time when terminal close (against rewrite by default)
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

# Dirs stack setting
setopt AUTO_PUSHD                   # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS            # Do not store duplicates in the stack.
setopt PUSHD_SILENT                 # Do not print the directory stack after pushd or popd.

alias d='dirs -v'
dirstacksize=12
for index ({1..${dirstacksize}}) alias "d$index"="cd +${index}"; unset index

# Autocomplete
setopt AUTO_MENU        # 1st tab create menu; 2nd go throught it

# Extra modification files
ZSH_EXT="$HOME/zsh-extentions"
source "$ZSH_EXT/aliases.zsh"
source <(fzf --zsh)

# Styling
zstyle ':vcs_info:git:*' formats '[%b]'         # Format the vcs_info_msg_0_ variable
# Case-insensitive completion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*' file-sort modification   # Order files by modification
# # Block huge amount possibilities ask
zstyle ':completion:*' list-prompt   ''
zstyle ':completion:*' select-prompt ''

# Base keybinds
# Enable vim (mostly useless)
bindkey -v 
# Vim analogy history search
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward
# Delete left/right part of text respectively coursor
bindkey '^J' backward-kill-word
bindkey '^K' kill-line
bindkey -r '^U'                 # Predefined duplicate ^J cmd

# Fzf history/cmd
export FZF_CTRL_R_OPTS="
    --color header:italic
    --reverse
    --ignore-case
    --header 'Search command in history...'"

# # Set only helpful keybinds from fzf
# bindkey -M vicmd '^R' fzf-history-widget
# bindkey '^R' fzf-history-widget

# ZPLUG Module
source ~/.zplug/init.zsh

# zplug 'Aloxaf/fzf-tab'
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-syntax-highlighting'

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf 'Install? [y/N]: '
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

# Plugins settigns
# Autosuggestion
ZSH_AUTOSUGGEST_STRATEGY=(history completion)       # Autocompletion search order 
bindkey '\ek' autosuggest-accept        # Accept
bindkey '\em' autosuggest-execute       # Accept and run
bindkey '\el' forward-word              # Accept word by word
# bindkey '\ec' autosuggest-clear         # Clear suggestion
# bindkey '\ez' autosuggest-toggle        # Enable/disable suggestion

# # Fzf-tab
# zstyle ':fzf-tab:*' fzf-flags --ignore-case
# bindkey '^z' toggle-fzf-tab
