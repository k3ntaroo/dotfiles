# .zshrc

## XDG Base Directory Specification
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"

# general
set -o emacs
export LANG=en_US.utf8
export WORDCHARS='*?_.[]~-=&;!#$%^(){}|<>'
export TERM=xterm-256color
export PATH=${HOME}/.local/bin:${PATH}

# enable better auto-completion
autoload -U compinit
compinit -u -d "${XDG_CACHE_HOME}/zsh/zcompdump"

# prompt
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' formats "%F{yellow}[%b]%f"
precmd () { vcs_info }

PROMPT="%F{cyan}%n@%m %~ \$vcs_info_msg_0_
%F{cyan}λ%f "

# history
setopt hist_ignore_dups
setopt hist_no_store
export HISTFILE=${XDG_DATA_HOME}/zsh/history
export HISTSIZE=1000
export SAVEHIST=1000

# less
export LESSCHARSET=utf-8
export LESSHISTFILE=-

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

# rlwrap
export RLWRAP_HOME="${XDG_DATA_HOME}/rlwrap"

# [golang] GOPATH
if which go > /dev/null; then
    export GOPATH=${HOME}/go
    append_PATH ${GOPATH}/bin
fi

# [ruby] gem
export GEM_HOME="${XDG_DATA_HOME}"/gem
export GEM_SPEC_CACHE="${XDG_CACHE_HOME}"/gem

# [ruby] bundler
export BUNDLE_USER_CONFIG="${XDG_CONFIG_HOME}"/bundle
export BUNDLE_USER_CACHE="${XDG_CACHE_HOME}"/bundle
export BUNDLE_USER_PLUGIN="${XDG_DATA_HOME}"/bundle

# [ruby] rbenv
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

# [javascript] npm
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"

# [ocaml] opam
export OPAMROOT="${XDG_DATA_HOME}/opam"
if which opam > /dev/null; then
    . ${OPAMROOT}/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
    eval `opam config env`
fi

# [haskell] stack
export STACK_ROOT="${XDG_DATA_HOME}"/stack

# [rust] cargo
export CARGO_HOME="${XDG_DATA_HOME}"/cargo

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

    alias sr='screenresolution'
    alias g++='g++-7 -std=c++14 -Wall'
fi

# aliases
alias gosh='rlwrap gosh'
alias ocaml='rlwrap ocaml'
alias sbcl='rlwrap sbcl'
alias clang++='clang++ --std=c++14 -Wall'
alias ghc='stack ghc --'
alias ghci='stack ghci --'
alias tmux="tmux -f '${XDG_CONFIG_HOME}/tmux/init'"
