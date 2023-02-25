# Verbosity and color alias
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -vI"
alias rmd="rm -rfiv"
alias rmdf="rm -rfv"
alias mkd="mkdir -pv"
alias bc="bc -ql"
alias df="df -h"
alias free="free -m"
alias diff="diff --color=auto"
# alias ls="exa --color=always"
alias ls="ls --color=always"
alias l="ls"
alias ll="ls -alF"

# Rust tool
alias rg="rg --hidden"
alias fd="fd" # on ubuntu
alias bat="bat" # on ubuntu
alias cat="bat -p"
alias catl="bat"
set -x MANPAGER "sh -c 'sed -e s/.\\\\x08//g | bat -l man -p'" 

# Vim
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias vimdiff="nvim -d"

# Git aliases
alias g="git"
alias ga="git add"
alias gb="git branch"
alias gc="git commit"
alias gcm="git commit -m"
alias gd="git diff"
alias gs="git status"
alias gp="git push"
alias gm="git merge"
alias gl="git log"
alias gpl="git pull"
alias gco="git checkout"

# Docker
alias dils="docker image ls"
alias dcls="docker container ls"
alias dvls="docker volume ls"
alias dnls="docker network ls"
alias dpsa="docker ps --all"
alias drma="docker system prune -a -f && docker volume prune -f"

# TUM Vpn
alias tumvpn="/opt/cisco/anyconnect/bin/vpn -s < ~/.ssh/vpn.pass connect asa-cluster.lrz.de"
alias tumvpnk="/opt/cisco/anyconnect/bin/vpn disconnect asa-cluster.lrz.de"

# Fish
alias ali="nvim ~/.config/fish/conf.d/aliases.fish"
