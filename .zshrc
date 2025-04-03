# =============================
# prompt
# =============================
THEME=catppuccin-mocha

setopt PROMPT_SUBST
NEWLINE=$'\n'
PS1="${NEWLINE}${NEWLINE} %B%K{green}%F{black} %~ %f%k %F{green}>%f%b "

if [[ "$THEME" = "catppuccin-mocha" ]]; then
  PS1="${NEWLINE}${NEWLINE} %B%K{magenta}%F{black} %~ %f%k %F{magenta}>%f%b "
fi
if [[ "$THEME" = "rose-pine" ]]; then
  PS1="${NEWLINE}${NEWLINE} %B%K{white}%F{black} %~ %f%k %F{white}>%f%b "
fi


# =============================
# env variables and options
# =============================

if [[ -f "$HOME/.env" ]]; then
  source $HOME/.env
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi

export AWS_PROFILE=non-prod
export AWS_DEFAULT_PROFILE=non-prod
export EDITOR=nvim
export BAT_THEME="$THEME"
export ZK_NOTEBOOK_DIR="$HOME/notes"

export HISTFILE=~/.zsh_history
export HISTSIZE=500000
export SAVEHIST=500000
setopt INC_APPEND_HISTORY_TIME

bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search

bindkey -e

# disable xon/xoff flow control to allow more keybinds
stty -ixon


# =============================
# aliases
# =============================

function commit {
  if [[ $# -eq 2 ]]; then
    vcNum=$(git branch --show-current | grep -o -E '[0-9]+')
    echo "\n$: git commit -m \"$1: vc-"$vcNum" $2\"\n"
    git commit -m "$1: vc-"$vcNum" $2"
  else
    echo "Usage: commit [commit type] [commit message]"
  fi
}

function newb {
  if [[ $# -eq 3 ]]; then
    echo "\n$: git checkout -b "$1/vc-$2_${3// /_}"\n"
    git checkout -b "$1/vc-$2_${3// /_}"
  else
    echo "Usage: newb [branch type] [vc number] [branch description]"
  fi
}

alias pushu="git push -u origin HEAD" 
alias glog="git log --oneline "
alias gs="git status -sb"
alias gq="git checkout qa-test"
alias kb="kubectl"
alias kx="kubectx"

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dot=dotfiles

#alias bat="batcat"
alias cat="bat"
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --group-directories-first"


# =============================
# plugins
# =============================

ZPLUGINDIR=$HOME/.zsh/plugins

if [[ ! -d $ZPLUGINDIR/zsh-autosuggestions ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZPLUGINDIR/zsh-autosuggestions
fi
source $ZPLUGINDIR/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
bindkey '^y' autosuggest-accept

if [[ ! -d $ZPLUGINDIR/zsh-syntax-highlighting ]]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZPLUGINDIR/zsh-syntax-highlighting
fi
source $ZPLUGINDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if [[ ! -d $ZPLUGINDIR/zsh-autopair ]]; then
  git clone https://github.com/hlissner/zsh-autopair $ZPLUGINDIR/zsh-autopair
fi
source $ZPLUGINDIR/zsh-autopair/autopair.zsh
autopair-init


# =============================
# super important scripts
# =============================

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source <(kubectl completion zsh)

neofetch


# =============================
# fzf configuration
# =============================
if [[ -d "$HOME/.fzf/bin" ]]; then
  if [[ ! "$PATH" == "*$HOME/.fzf/bin*" ]]; then
    PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
  fi
fi

eval "$(fzf --zsh)"

function fzf_search_specific_dirs {
  local selected_dir
  selected_dir=$(find ~/repos ~/repos/rust-beginnings -maxdepth 1 -type d | fzf)

  if [[ -n $selected_dir ]]; then
    cd "$selected_dir" || return
  fi
}

function fzf_search_git_branches {
  local selected_branch
  selected_branch=$(git branch --sort=-committerdate | fzf | tr -d ' ')

  if [[ -n $selected_branch ]]; then
    echo "\n$: git checkout "$selected_branch"\n"
    git checkout "$selected_branch"
  fi
}

bindkey -s ^f "fzf_search_specific_dirs\n"
bindkey -s ^b "fzf_search_git_branches\n"
bindkey "^q" end-of-line

if [[ "$(tty)" = "/dev/tty1" ]]; then
  exec startx
fi
