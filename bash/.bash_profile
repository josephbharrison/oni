# command test
function cmd(){ command -v $1 &> /dev/null; return $?;}

# Base
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && source "/usr/local/etc/profile.d/bash_completion.sh"
export PATH=${PATH}:/usr/local/bin
export BASH_SILENCE_DEPRECATION_WARNING=1
export GID=$(id -g)
alias ls='ls -Gh'
alias ll='ls -la'
alias vi='nvim'

# Homebrew
if [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]]; then # Linux
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else # MacOS
    cmd /opt/homebrew/bin/brew && eval "$(/opt/homebrew/bin/brew shellenv)"
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
       . $(brew --prefix)/etc/bash_completion
    fi
fi
alias fb='/bin/bash -c "NONINTERACTIVE=1 $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'

# Local dev automation
export CODE_HOME=${HOME}/code
export ONI_HOME=${CODE_HOME}/oni
export PROJECT=${PWD##*/}
source ${ONI_HOME}/extras/.aliases
[[ -f ${CODE_HOME}/${PROJECT}/.aliases ]] && source ${CODE_HOME}/${PROJECT}/.aliases

# Kubernetes
export KUBECONFIG=~/.kube/config
if [[ -d $(brew --prefix)/etc/bash_completion.d ]]; then
    kubectl completion bash > $(brew --prefix)/etc/bash_completion.d/kubectl
fi
source <(kubectl completion bash)

# Google
export GSDK="$HOME/google-cloud-sdk"
f="$GSDK/path.bash.inc" && [[ -f $f ]] && source $f
f="$GSDK/completion.bash.inc" && [[ -f $f ]] && source $f
# export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# Go
cmd go && export PATH="$PATH:$(go env GOPATH)/bin"
export GO111MODULE=on

# Rust
export PATH="$PATH:$HOME/.cargo/bin"
. "$HOME/.cargo/env"

# Azure (eww)
export GOPRIVATE=dev.azure.com

# Node
cmd node && source $(brew --prefix nvm)/nvm.sh
export NVM_DIR=~/.nvm
export PATH=${PATH}:node_modules/.bin

## GNU
export PATH="/opt/homebrew/opt/gnu-getopt/bin:$PATH"

## Docker
export PATH=/usr/local/opt/docker-compose/bin:${PATH}
export PATH=/opt/homebrew/bin/docker-buildx:${PATH}

## iCloud
alias password='tail -1 ~/Documents/passwords.txt'

# Starship
eval "$(starship init bash)"

# Terminal overrides
set -o vi
export TERM="xterm-256color"

## Import Secrets
[[ -f ~/.secrets ]] && source ~/.secrets
