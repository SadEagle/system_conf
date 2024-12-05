autoload -Uz vcs_info compinit &&
                        compinit
precmd() { vcs_info }

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST                 # Enable external variables inside prompt (vcs_info_msg_0_)
PROMPT='%F{green}%\%n %F{blue}%\%~ %F{cyan}%\\${vcs_info_msg_0_}%F{white}%\\❭ '

# History settings
export HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS             # Dont include duplicate the previous command
setopt APPENDHISTORY                # Add terminal history (dont rewrite)
setopt HIST_EXPIRE_DUPS_FIRST       # If HISTSIZE > SAVEHIST, then cut duplicates cmds to put more original commands
setopt INC_APPEND_HISTORY_TIME      # Store commands at use time when terminal close (against rewrite by default)
export HISTSIZE=100000               # Maximum events for internal history
export SAVEHIST=100000               # Maximum events in history file

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

 # Git add completion very long
 # https://superuser.com/questions/458906/zsh-tab-completion-of-git-commands-is-very-slow-how-can-i-turn-it-off
 __git_files () { 
    _wanted files expl 'local files' _files     
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
zstyle ':vcs_info:git:*' formats '[%b] '         # Format the vcs_info_msg_0_ variable
# Case-insensitive completion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*' file-sort modification   # Order files by modification
# # Block ask about explicit display amount
# zstyle ':completion:*' list-prompt   ''
# zstyle ':completion:*' select-prompt ''

# Base keybinds
# Enable vim (mostly useless)
bindkey -v 
# Show default keys in fzf block
# Ctrl-R, Ctrl-T, Alt-C
# Much more it may use fzf by ```cmd <some suffix>**<Tab>```. Works different to completion with [kill, ssh, export, unalias, ...]
#
# Vim analogy history search
bindkey '^p' history-beginning-search-backward
bindkey '^n' history-beginning-search-forward
# Delete left/right part of text respectively coursor
bindkey '^j' backward-kill-word
bindkey '^k' kill-line

bindkey '^[[3~' delete-char     # Fix broken 'Del'
bindkey -r '^u'                 # Predefined duplicate ^J cmd

# Fzf history/cmd
export FZF_DEFAULT_OPTS='--bind=tab:down,shift-tab:up --height=60%'
export FZF_CTRL_R_OPTS="
    --color header:italic
    --reverse
    --ignore-case
    --header 'Search command in history...'"

export FZF_CTRL_T_OPTS="
    --header 'Search file in current directory and add to cmd...'"

export FZF_ALT_C_OPTS="
    --header 'Search and jump in directory...'"

# ZPLUG Module
source ~/.zplug/init.zsh

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
