

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
# For kitty on Hyprland, keep the prompt simple and let kitty handle colors
case "$TERM" in
    xterm-kitty|screen-256color|tmux-256color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# Use a simple prompt without escape sequence wrapping issues
if [ "$color_prompt" = yes ]; then
    # Simple prompt - let kitty handle colors via its theme
    PS1='\u@\h:\w\$ '
else
    PS1='\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
fi

# Define the function we'll use for imports
load() {
  if [ -f "$1" ]; then
    . "$1"
  fi
}

#Load env vars DON'T COMMIT THESE
load ~/scripts/env.sh

# Load global definitions
load /etc/bashrc

# load highlighter
load ~/scripts/h.sh

# Load aliases
load ~/scripts/aliases.sh

# Load functions
load ~/scripts/functions.sh

# Load color settings
load ~/scripts/colors.sh

# Load prompt
load ~/scripts/prompt.sh
# Load title
load ~/scripts/title.sh

#Load docker scripts
load ~/scripts/docker_scripts.sh

# Add scripts to path
PATH=$PATH':/sbin'
PATH=$PATH':~/scripts'
PATH=$PATH':~/scripts/binaries'
PATH=$PATH':~/.ip-scripts'
PATH=$PATH':/usr/local/nvm/v5.4.1/bin'
PATH=$PATH':~/.local/bin'
PATH=$PATH'/usr/local/lib64/'
export DENO_INSTALL="/home/will/.deno"
  export PATH="$DENO_INSTALL/bin:$PATH"

# Suppress nvm errors...
unset NPM_CONFIG_PREFIX


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

export NVM_DIR="/home/$(whoami)/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
