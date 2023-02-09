#!/usr/bin/env bash

# Get timestamp
now=$(date +%s)

# GLOBAL PARAMETERS
FONTS="hack mononoki go-mono jetbrains-mono open-dyslexic"
ASTRONVIM_REPO=https://github.com/AstroNvim/AstroNvim
MY_REPO=https://github.com/josephbharrison/oni

# install base configuration only
[[ $1 == "base" ]] && echo "Installing base astronvim only" && BASE_ONLY=true

TMP_DIR=${HOME}/tmp
SOURCE_DIR=${TMP_DIR}/oni
CONFIG_DIR=${HOME}/.config
 
# null
function null(){
    "$@" &> /dev/null
}

# Verify homebrew install
function check_prereqs(){
    echo -en "Checking prereqs: "
    res=$(brew list)
    if [[ $? -ne 0 ]]; then
        echo "MISSING"
        echo "Installing homebrew: "
        /bin/bash -c "NONINTERACTIVE=1 $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    null brew update
}

function fail(){
    echo "FAIL"
    exit 1
}

function ok(){
    echo "OK"
}

function brewster(){
    package=$1
    name=$2
    [[ -z $name ]] && name=$package
    # Install tmux
    res=$(null brew list $package)
    if [[ $? -ne 0 ]]; then
        echo -en "Installing $name: "
        null brew install $package || return 1
    else
        echo -en "Updating $name: "
        null brew upgrade $package || return 1
    fi
    return 0
}

function install_fonts(){
    # Install fonts
    echo -en "Installing fonts: "
    for font in $FONTS
    do
        res=$(null brew list --cask font-${font}-nerd-font)
        if [[ $? -ne 0 ]]; then
            null sudo rm -f $HOME/Library/Fonts/${font}*
            null brew tap homebrew/cask-fonts && 
            null brew install --cask font-${font}-nerd-font || return 1
        fi
    done
    return 0
}

function install_tmux(){
    brewster tmux
}

function install_tldr(){
    brewster tealdeer tldr
    null tldr --update
    return 0
}

function install_fzf(){
    brewster fzf
}


function install_wezterm(){
    # Install wezterm
    res=$(null brew list wezterm-nightly)
    if [[ $? -ne 0 ]]; then
        echo -en "Installing wezterm: "
        null brew tap wez/wezterm
        null brew install --cask wez/wezterm/wezterm-nightly || return 1
    else
        echo -en "Updating wezterm: "
        null brew upgrade --cask wez/wezterm/wezterm-nightly --no-quarantine --greedy-latest || return 1
    fi
    return 0
}

function install_neovim(){
    brewster nvim neovim
}

# Configure NeoVim
function configure_environment(){
    mkdir -p $TMP_DIR
    echo -en "Configuring oni: "

    # Backup existing configurations
    [[ -d $CONFIG_DIR ]] && null cp -rf $CONFIG_DIR ${CONFIG_DIR}.${now}.bak
    mkdir -p $CONFIG_DIR

    # Download configurations
    [[ -d $SOURCE_DIR ]] && rm -rf $SOURCE_DIR
    null git clone $MY_REPO $SOURCE_DIR || return 1

    # Configure nvim
    nvim_site_dir="${HOME}/.local/share/nvim/site"
    [[ -d $nvim_site_dir ]] && mv -f $nvim_site_dir ${nvim_site_dir}.${now}.bak
    [[ -d $CONFIG_DIR/nvim ]] && rm -rf $CONFIG_DIR/nvim
    if [[ $BASE_ONLY != true ]];then
        cp -r $SOURCE_DIR/nvim $CONFIG_DIR/nvim || return 1
    else
        null git clone $ASTRONVIM_REPO $CONFIG_DIR/nvim || return 1
    fi

    # Configure tmux
    [[ -d $CONFIG_DIR/tmux ]] && rm -rf $CONFIG_DIR/tmux
    mkdir -p $CONFIG_DIR/tmux
    cp $SOURCE_DIR/tmux/tmux.conf $CONFIG_DIR/tmux/tmux.conf 
    null git clone https://github.com/tmux-plugins/tpm $CONFIG_DIR/tmux/plugins/tpm
    null $CONFIG_DIR/tmux/plugins/tpm/bin/install_plugins

    # Configure wezterm
    [[ -d $CONFIG_DIR/wezterm ]] && rm -rf $CONFIG_DIR/wezterm
    mkdir -p $CONFIG_DIR/wezterm
    cp -f $SOURCE_DIR/wezterm/* $CONFIG_DIR/wezterm/

    # Configure starship
    [[ -d $CONFIG_DIR/starship ]] && rm -rf $CONFIG_DIR/starship
    mkdir -p $CONFIG_DIR/starship
    cp -f $SOURCE_DIR/starship/* $CONFIG_DIR/starship/
    cp $SOURCE_DIR/starship/default.toml $CONFIG_DIR/starship.toml

    # Configure bash
    [[ -f ~/.bash_profile ]] && mv -f ~/.bash_profile ~/.bash_profile.${now}.bak
    cp -f $SOURCE_DIR/bash/.bash_profile ${HOME}/.bash_profile

    return 0
}

function packer_count(){
    echo $(ps -ef | grep -c "/[p]acker/")
}

function packer_sync(){
    # HEADLESS INSTALL
    echo -en "Updating neovim packages: "
    null nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' &
    while [[ $(packer_count) -gt 0 ]]
    do
        sleep 1
    done
}

function install(){
    installers="check_prereqs install_fonts install_tmux install_tldr install_fzf install_wezterm install_neovim configure_environment"
    for installer in $installers
    do
        $installer && ok || fail
    done

    echo "Installation complete"
}

function getting_started(){
    cat $SOURCE_DIR/images/oninvim.ansi
    echo
    echo " Oni successfully installed!"
    echo
    echo " Configurations:"
    echo
    echo "   tmux        ${HOME}/.config/tmux/tmux.conf"
    echo "   neovim      ${HOME}/.config/nvim/lua/user/init.lua"
    echo "   wezterm     ${HOME}/.config/wezterm/wezterm.lua"
    echo "   starship    ${HOME}/.config/starship.toml"
    echo 
    echo " Mappings:"
    echo 
    echo "   neovim :help map"
    echo "   tmux list-keys"
    echo "   wezterm show-keys"
    echo
    echo " Run:"
    echo
    echo "   nvim +PackerSync"
}

install

export MSG="$(getting_started)"; wezterm start -- bash -c "echo -e '$MSG'; bash"

