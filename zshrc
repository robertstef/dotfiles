#!/bin/zsh

######
# TMUX
######
if [[ $TMUX ]]; then
    # Start copyq server if it is not already running
    if ! pgrep copyq > /dev/null; then
        copyq &
    fi
fi


###########
# Variables
###########
# VIM_PATH="/home/rstefany/vim/installed/bin"
# TMUX_PATH="/home/rstefany/tmux"
# export PATH="$VIM_PATH:$TMUX_PATH:$PATH:/usr/sbin"

export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} history -a"
export EDITOR='nvim'
export VISUAL='nvim'
export PS1="[\u@\h] \[\e[32m\]\w \[\e[91m\]\$(parse_git_branch)\[\e[00m\] \n~> "


###########
# Functions
###########
parse_git_branch() {
    # Displays current git branch if cwd is a git repo
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

mcd() {
    # Make the specified directory and cds into it
    mkdir -p $1
    cd $1
}

mk-script() {
    if [[ $# != 1 ]]; then
        echo "mk-script requires a single file argument."
        exit
    fi

    # Makes a file with user permissions set to rwx
    touch $1
    chmod u+rwx $1
    echo "#!/bin/zsh" > $1
}


##########
# Settings
##########
set -o vi  # vim keybinding in command prompt
force_color_prompt=yes
# Put here because putting ls alias in .bash_aliases gets overwritten by other setup scripts
# alias ls='ls --ignore=*.pyc --color=auto'


#########
# Plugins
#########
# source /usr/share/autojump/autojump.bash # autojump
eval "$(starship init zsh)" # Enable starship theme

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
