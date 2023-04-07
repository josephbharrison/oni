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
 
# nullify output
function null(){
    "$@" &> /dev/null
}

# Prerequisite checker
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

# fail and exit
function fail(){
    echo "FAIL"
    exit 1
}

# OK response
function ok(){
    echo "OK"
}

# package installer
function brewster(){
    package=$1
    name=$2
    [[ -z $name ]] && name=$package
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

# font installer
function install_fonts(){
    echo -en "Installing fonts: "
    for font in $FONTS
    do
        if [[ $? -ne 0 ]]; then
            null git clone --filter=blob:none --sparse https://github.com/ryanoasis/nerd-fonts.git  
            null cd nerd-fonts
            null install.sh 
        fi
    done
    return 0
}

# tmux installer
function install_tmux(){
    brewster tmux
}

# tldr installer
function install_tldr(){
    brewster tealdeer tldr
    null tldr --update
    return 0
}

# fzf installer
function install_fzf(){
    brewster fzf
}

# stern installer
function install_stern(){
    brewster stern
}

# kubectl installer
function install_kubectl(){
    brewster kubectl
}


# wezterm installer
function install_wezterm(){
    # Install wezterm
    res=$(null brew list wezterm-nightly)
    if [[ $? -ne 0 ]]; then
        echo -en "Installing wezterm: "
        null brew tap wez/wezterm
        null brew install --cask wez/wezterm/wezterm-nightly --force || return 1
    else
        echo -en "Updating wezterm: "
        null brew upgrade --cask wez/wezterm/wezterm-nightly --no-quarantine --greedy-latest --force || return 1
    fi
    return 0
}

# neovim installer
function install_neovim(){
    brewster nvim neovim
}

# Track packer installers
function packer_count(){
    echo $(ps -ef | grep -c "/[p]acker/")
}

# neovim package installer
function packer_sync(){
    null nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' &
    while [[ $(packer_count) -gt 0 ]]
    do
        sleep 1
    done
    return 0
}

# Configure Oni
function configure_oni(){
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
    packer_sync

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

# Main installer
function install(){
    # oni components
    components="fonts tmux tldr fzf kubectl stern wezterm neovim"
    for component in $components
    do
        installers="${installers} install_${component}"
    done

    # initialize installers
    steps="check_prereqs $installers"
    for step in $steps
    do
        $step && ok || fail
    done

    if [[ $@ != *"--skip-configure"* ]]; then
        configure_oni && ok || fail
    fi

    echo "Installation complete"
}

# Post install message
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
    echo
}

# initialize main installer
install $@

# exit on optional input
[[ -e $@ ]] && exit 0

# launch wezterm with `getting_started` message
export MSG="$(getting_started)"; wezterm start -- bash -c "echo -e '$MSG'; bash"

