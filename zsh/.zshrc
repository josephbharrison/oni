# Command existence check function
cmd() { command -v $1 &> /dev/null; return $?; }

# Base configurations
export PATH=${PATH}:/usr/local/bin
export GID=$(id -g)
alias ls='ls -Gh'
alias ll='ls -la'
alias vi='nvim'

# Homebrew setup
if [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif cmd /opt/homebrew/bin/brew; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
alias fb='/bin/zsh -c "NONINTERACTIVE=1 $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'

# Local development environment
export CODE_HOME=${HOME}/code
export ONI_HOME=${CODE_HOME}/oni
export PROJECT=${${PWD##*/}#*/}
autoload -Uz compinit
compinit
source ${ONI_HOME}/extras/.aliases.zsh
[[ -f ${CODE_HOME}/${PROJECT}/.aliases.zsh ]] && source ${CODE_HOME}/${PROJECT}/.aliases.zsh

# Kubernetes
export KUBECONFIG=~/.kube/config
if cmd kubectl; then
    source <(kubectl completion zsh)
fi

# Google Cloud SDK
export GSDK="$HOME/google-cloud-sdk"
[[ -f "$GSDK/path.zsh.inc" ]] && source "$GSDK/path.zsh.inc"
[[ -f "$GSDK/completion.zsh.inc" ]] && source "$GSDK/completion.zsh.inc"

# Go language setup
cmd go && export PATH="$PATH:$(go env GOPATH)/bin"
export GO111MODULE=on

# Rust setup
export PATH="$PATH:$HOME/.cargo/bin"
[[ -s "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# Azure
export GOPRIVATE=dev.azure.com

# Node.js setup
cmd node && source $(brew --prefix nvm)/nvm.sh
export NVM_DIR=~/.nvm
export PATH=${PATH}:node_modules/.bin

# GNU utilities
export PATH="/opt/homebrew/opt/gnu-getopt/bin:$PATH"

# Docker
export PATH=/usr/local/opt/docker-compose/bin:${PATH}
export PATH=/opt/homebrew/bin/docker-buildx:${PATH}

# iCloud alias
alias password='tail -1 ~/Documents/passwords.txt'

# Starship prompt
eval "$(starship init zsh)"

# Terminal keybindings - vi mode
bindkey -v

# Terminal color scheme
export TERM="xterm-256color"

# Secrets
[[ -f ~/.secrets ]] && source ~/.secrets

# Oh-My-Zsh
export ZSH="$HOME/.oh-my-zsh"
plugins=(git)
source $ZSH/oh-my-zsh.sh
