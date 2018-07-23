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

PROMPT="%F{cyan}%~ \$vcs_info_msg_0_
%F{cyan}λ%f "

## history
setopt hist_ignore_dups
setopt hist_no_store
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000

export LANG=en_US.utf8
export WORDCHARS='*?_.[]~-=&;!#$%^(){}|<>' # word characters
export XDG_CONFIG_HOME=${HOME}/.config    # base directory
export TERM=xterm-256color                # use 256color
export PATH=${HOME}/.local/bin:${PATH}    # PATH
export LESSCHARSET=utf-8                  # apply utf-8 to less command

# path
append_PATH() {
    if ! [[ "$PATH" =~ (^|:)${1}($|:) ]]; then
        export PATH=${PATH}:${1}
    fi
}

prepend_PATH() {
    if ! [[ "$PATH" =~ (^|:)${1}($|:) ]]; then
        export PATH=${1}:${PATH}
    fi
}


# EDITOR
if which nvim > /dev/null; then
    export EDITOR=`which nvim`
else
    export EDITOR=`which vi`
fi

# golang
if which go > /dev/null; then
    export GOPATH=${HOME}/go
    append_PATH ${GOPATH}/bin
fi

# rbenv
if which rbenv > /dev/null; then
    eval "$(rbenv init -)"
fi

# [perl] plenv
if which plenv > /dev/null; then
    eval "$(plenv init - zsh)";
fi

# [python] pyenv
if which pyenv > /dev/null; then
    eval "$(pyenv init -)"
fi

# ocaml

## OPAM configuration
if which opam > /dev/null; then
    . ${HOME}/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
    eval `opam config env`
fi

# LLVM (installed by Homebrew)
prepend_PATH '/usr/local/opt/llvm/bin'

# use emacs bindings in prompt
set -o emacs

# macOS
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

# helpful functions
#
function cdd () {
    mkdir -p -- "$1" && cd -- "$1"
}

# aliases
alias clang++='clang++ --std=c++14 -Wall -o z.out'
alias g++='g++-7 -std=c++14 -Wall'
alias ghc='stack ghc --'
alias ghci='stack ghci --'
alias gosh='rlwrap gosh'
alias sr='screenresolution'
alias ocaml='rlwrap ocaml'
alias sbcl='rlwrap sbcl'
