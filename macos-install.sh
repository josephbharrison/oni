#!/usr/bin/env bash

# Get timestamp
now=$(date +%s)

# GLOBAL PARAMETERS
FONTS="hack mononoki go-mono jetbrains-mono sauce-code-pro open-dyslexic"
MY_REPO=https://github.com/josephbharrison/oni

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
    url="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"
    res=$(brew list)
    if [[ $? -ne 0 ]]; then
        echo "MISSING"
        echo "Installing homebrew: "
        /bin/bash -c "NONINTERACTIVE=1 $(curl -fsSL ${url})"
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
        res=$(null brew list --cask font-${font}-nerd-font)
        if [[ $? -ne 0 ]]; then
            [[ -f $HOME/Library/Fonts/${font}* ]] \
                && null sudo rm -f $HOME/Library/Fonts/${font}*
            null brew tap homebrew/cask-fonts && 
            null brew install --cask font-${font}-nerd-font --force || return 1
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
    res=$(null brew list wezterm)
    if [[ $? -ne 0 ]]; then
        echo -en "Installing wezterm: "
        null brew install --cask wezterm --force || return 1
    else
        echo -en "Updating wezterm: "
        null brew upgrade --cask wezterm --force || return 1
    fi
    return 0
}

# neovim installer
function install_neovim(){
    brewster nvim neovim
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

    # Configure oni-nvim
    nvim_site_dir="${HOME}/.local/share/nvim/site"
    [[ -d $nvim_site_dir ]] && mv -f $nvim_site_dir ${nvim_site_dir}.${now}.bak
    [[ -d $CONFIG_DIR/nvim ]] && rm -rf $CONFIG_DIR/nvim
    cp -r $SOURCE_DIR/nvim $CONFIG_DIR/nvim || return 1

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
    cp $SOURCE_DIR/starship/starship.macos $CONFIG_DIR/starship.toml

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
function start(){
    cat $SOURCE_DIR/images/startup-splash.ansi
}

# initialize main installer
install $@

# exit on optional input
[[ -e $@ ]] && exit 0

# launch wezterm with `getting_started` message
export MSG="$(start)"; wezterm --config background="{}" --config colors="{background='rgba(0,0,0,0.67)', selection_fg = 'none', selection_bg = 'rgba(50% 50% 50% 50%)',}" start -- bash -c "echo -e '$MSG'; bash"


