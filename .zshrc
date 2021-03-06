
# path
prepend_PATH() {
    if ! [[ "$PATH" =~ (^|:)${1}($|:) ]]; then
        export PATH=${1}:${PATH}
    fi
}

# XDG Base Directory Specification
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"

# general
set -o emacs
set -g default-terminal tmux-256color
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=tmux-256color
export WORDCHARS='*?_.[]~-=&;!#$%^(){}|<>'
prepend_PATH "/usr/local/bin"
prepend_PATH "${HOME}/.local/bin"

# enable better auto-completion
autoload -U compinit
compinit -u -d "${XDG_CACHE_HOME}/zsh/zcompdump"

# prompt
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' formats "%F{yellow}[%b]%f"
precmd () { vcs_info }

PROMPT="%F{cyan}%n@%m %~
%F{cyan}λ %f"

# history
setopt hist_ignore_dups
setopt hist_no_store
export HISTFILE=${XDG_DATA_HOME}/zsh/history
export HISTSIZE=1000
export SAVEHIST=1000

# less
export LESSCHARSET=utf-8
export LESSHISTFILE=-

# EDITOR
if which nvim > /dev/null; then
    export EDITOR=`which nvim`
else
    export EDITOR=`which vi`
fi

# rlwrap
if which rlwrap > /dev/null; then
    export RLWRAP_HOME="${XDG_DATA_HOME}/rlwrap"
fi

# [golang] GOPATH
if which go > /dev/null; then
    export GOPATH=${HOME}/go
    prepend_PATH "${GOPATH}/bin"
fi

# [ruby] gem
export GEM_HOME="${XDG_DATA_HOME}"/gem
export GEM_SPEC_CACHE="${XDG_CACHE_HOME}"/gem

# [ruby] bundler
export BUNDLE_USER_CONFIG="${XDG_CONFIG_HOME}"/bundle
export BUNDLE_USER_CACHE="${XDG_CACHE_HOME}"/bundle
export BUNDLE_USER_PLUGIN="${XDG_DATA_HOME}"/bundle

if which rbenv > /dev/null; then
    eval "$(rbenv init -)"
fi

if which pyenv > /dev/null; then
    eval "$(pyenv init -)"
fi

if which npm > /dev/null; then
    export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
fi

if which opam > /dev/null; then
    export OPAMROOT="${XDG_DATA_HOME}/opam"
    eval `opam env`
fi

if which stack > /dev/null; then
    export STACK_ROOT="${XDG_DATA_HOME}"/stack
fi

if which cargo > /dev/null; then
    export CARGO_HOME="${XDG_DATA_HOME}"/cargo
fi

# macOS
if [ `uname` = 'Darwin' ]; then
    # magic
    export __CF_USER_TEXT_ENCODING="0x$(printf %x $(id -u)):0x8000100:14"

    if which pbcopy > /dev/null; then
        copy () {
          cat $1 | pbcopy
        }
    fi
    alias ls='ls -FG'
elif [ `uname` = 'Linux' ]; then
    alias ls="ls -F --color=auto"
fi

# aliases
alias gosh='rlwrap gosh'
alias clang++='clang++ --std=c++14 -Wall'
alias ghc='stack ghc --'
alias ghci='stack ghci --'
alias tmux="tmux -f '${XDG_CONFIG_HOME}/tmux/init'"
