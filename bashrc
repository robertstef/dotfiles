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

# export R0HD1=/wv/sldcluster/liberty/Qualcomm/ql10lpe/r0hd_1_cell
# export R0HD2=/wv/sldcluster/liberty/Qualcomm/ql10lpe/r0hd_1_cell_3.02
# export LVF1=/project/scs/liberty/Mentor/c40/std_cell/moments_demo/2020-03-25
# export LVF2=/project/scs/liberty/Mentor/c40/std_cell/moments_demo/2021-03-18
# export GCTESTS=/export/worktrees/mlc-35719/src/mlchar/util/name_parsers/test/data/generic_corners
# export PYTHONNOUSERSITE=1
# export SOLIDO_LIVE_DEBUG=error
# 
# export MLC_TEST_ARTIFACTS_DIR=/bata/rstefany/mlc-testing
# export SKIP_LIMITED_FEATURES_KEY=1


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
    echo "#!/bin/bash" > $1
}


##########
# Settings
##########
set -o vi  # vim keybinding in command prompt
force_color_prompt=yes
# Put here because putting ls alias in .bash_aliases gets overwritten by other setup scripts
alias ls='ls --ignore=*.pyc --color=auto'


#########
# Plugins
#########
source /usr/share/autojump/autojump.bash # autojump
eval "$(starship init bash)" # Enable starship theme
