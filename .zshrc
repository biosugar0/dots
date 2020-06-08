export LANG=ja_JP.UTF-8

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

if [ -e ~/.zsh/completions ]; then
  fpath=(~/.zsh/completions $fpath)
fi

function precmd() {
  if [ ! -z $TMUX ]; then
    tmux refresh-client -S
  fi
}
setopt share_history
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward
autoload -U compinit
compinit
# Customize to your needs...
export GOPATH=`go env GOPATH`
export GOROOT=`go env GOROOT`
export PATH="$GOPATH/bin:$PATH"
export BASE_DIR=~/go
export EDITOR=vim
export VISUAL=vim
eval "$(direnv hook zsh)"

alias g='cd $(ghq root)/$(ghq list | peco)'
alias gh='cd $(ghq root)/github.com'

c () {
    if [ $# -gt 0 ]; then
        \cd "$@"
        return
    fi
    local gitroot=`git rev-parse --show-toplevel 2>/dev/null`
    if [ ! "$gitroot" = "" ]; then
        \cd "$gitroot"
        return
    fi
    \cd
}

alias gitclean='git branch --merged|egrep -v "\*|develop|master"|xargs git branch -d && git fetch --prune'
alias time='gtime -f %E'
alias vi='/usr/local/bin/vim'
alias gdn='git diff --name-only'
alias dgc='docker container prune -f  && docker image prune -f '
source <(kubectl completion zsh)
alias k='kubectl'
export DOCKER_BUILDKIT=1
export PATH="${PATH}:${HOME}/.krew/bin"
