# .zshrc

# zsh confs

## enable better auto-completion
autoload -U compinit
compinit -u

## prompt config
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' formats "%F{yellow}[%b]%f"
precmd () { vcs_info }

PROMPT="%F{cyan}%n @ %~ \$vcs_info_msg_0_
%F{cyan}λ%f "

## history
setopt hist_ignore_dups
setopt hist_no_store
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000

## set word characters
export WORDCHARS='*?_.[]~-=&;!#$%^(){}<>'

# xdg base directory
export XDG_CONFIG_HOME=${HOME}/.config

# use 256color
export TERM=xterm-256color

# EDITOR
if which nvim > /dev/null; then
  export EDITOR=`which nvim`
else
  export EDITOR=`which vi`
fi

# PATH
export PATH=${HOME}/.local/bin:${PATH}

# golang
if which go > /dev/null; then
    export GOROOT=`go env GOROOT`
    export GOPATH=${HOME}/go
    export PATH=${PATH}:${GOROOT}/bin:${GOPATH}/bin
fi

# rbenv
if which rbenv > /dev/null; then
    eval "$(rbenv init -)"
fi

# [perl] plenv
if which plenv > /dev/null; then eval "$(plenv init - zsh)"; fi

# [python] pyenv
if which pyenv > /dev/null; then
    eval "$(pyenv init -)"
fi

# OPAM configuration
if which opam > /dev/null; then
    . ${HOME}/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
fi

# aliases
alias clang++='clang++ -O2 -std=c++14 -Wall -o z.out'
alias coqtop='rlwrap coqtop'
alias g++='g++-7 -std=c++14 -Wall'
alias ghc='stack ghc --'
alias ghci='stack ghci --'
alias gosh='rlwrap gosh'
alias ocaml='rlwrap ocaml'
alias sml='rlwrap sml'
alias sr='screenresolution'

# use emacs bindings in prompt
set -o emacs

# macos
if [ `uname` = 'Darwin' ]; then
    ## copy function
    if which pbcopy > /dev/null; then
        copy () {
          cat $1 | pbcopy
        }
    fi

    ## BSD ls
    alias ls='ls -FG'
fi

function timer() {
    echo 0
    for i in `seq $1`; do
        sleep 1
        echo $i
    done
}
