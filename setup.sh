#!/bin/zsh

# Check we have everything we need to run the setup
REQ_CMDS=("brew" "tmux" "nvim")
for CMD in ${REQ_CMDS[@]}; do
    if ! command -v $CMD 2>&1 >/dev/null; then
        echo "ERROR: $CMD is required for setup to run. Please install it."
        exit
    fi
done

# Make sure tmux is not ancient
TMUX_VERSION=${$(tmux -V | cut -d ' ' -f 2)%?}
if [[ $TMUX_VERSION -lt 1.9 ]]; then
    echo "ERROR: tmux version must be greater than 1.9. Current version is $TMUX_VERSION"
    exit
fi

# Install required programs/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm  # TPM
brew install copyq
brew install font-fira-code-nerd-font
brew install starship
brew install autojump

# Symlink files in repo to their expected locations
CWD=$(pwd)
SRC_FILES=("$CWD/nvim" 
           "$CWD/tmux.conf" 
           "$CWD/zshrc" 
           "$CWD/starship.toml")
DST_FILES=("$HOME/.config/nvim" 
           "$HOME/.tmux.conf" 
           "$HOME/.zshrc" 
           "$HOME/.config/starship.toml")

for ((i=1; i<=${#DST_FILES[@]}; i++)); do
    if [[ -f ${DST_FILES[i]} ]]; then
        BASE=$(basename ${DST_FILES[i]})
        DIR=$(dirname ${DST_FILES[i]})
        mv ${DST_FILES[i]} "$DIR/tmp_$BASE"
    fi

    ln -s ${SRC_FILES[i]} ${DST_FILES[i]}
done



