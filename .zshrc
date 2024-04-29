# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

source $ZSH/oh-my-zsh.sh

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

setopt PROMPT_SUBST
NEWLINE=$'\n'
PROMPT="${NEWLINE}${NEWLINE} %B%K{magenta}%F{black} %~ %f%k %F{magenta}>%f%b "

source /opt/homebrew/opt/zsh-syntax-highlighting

alias python="python3"
alias venv="virtualenv"
alias vim="nvim"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Colorise the top Tabs of Iterm2 with the same color as background
# Just change the 18/26/33 wich are the rgb values
echo -e "\033]6;1;bg;red;brightness;18\a"
echo -e "\033]6;1;bg;green;brightness;26\a"
echo -e "\033]6;1;bg;blue;brightness;33\a"

eval "$(fzf --zsh)"

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

# Pushes current branch upstream with the branch name
function pushu {
  echo "\n$: git push -u origin HEAD\n"
  git push -u origin HEAD
}

function glog {
  git log --oneline
}

function gs {
  git status -sb
}

function gq {
  git checkout qa-test
}

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

export PATH="/Users/hakontm/Library/Python/3.10/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
export AWS_PROFILE=videocation-main
export EDITOR=nvim
export NEOVIDE_FRAME=none
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
