autoload -Uz colors   && colors  # For easy color scheme setting
autoload -Uz compinit && compinit  # For complition

################################################################################
# brew
################################################################################
if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
if [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi


################################################################################
# Language
################################################################################
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8


################################################################################
# Completion
################################################################################
# Use modern completion system
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
case ${OSTYPE} in
    linux*)
        eval "$(dircolors -b)"
        ;;
    darwin*)
        eval "$(gdircolors -b)"
        ;;
esac
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'


################################################################################
## Prompt
################################################################################
setopt prompt_subst


# Git status and git branch in prompt
# cf. https://qiita.com/nishina555/items/f4f1ddc6ed7b0b296825
# cf. https://stackoverflow.com/questions/39689789/zsh-setopt-prompt-subst-not-working
# Color list one-liner: `for c in {000..255}; do echo -n "\e[38;5;${c}m $c" ; [ $(($c%16)) -eq 15 ] && echo; done; echo`

function prompt-git-current-branch() {
  local branch_name git_status status_color

  git status > /dev/null 2> /dev/null
  if [ $? != 0 ]; then
    # Return if here is not a git repository
    return
  fi

  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  git_status=`git status 2> /dev/null`
  readonly branch_name
  readonly git_status

  # Choose down color by git repository status
  if [[ -n `echo "${git_status}" | grep "^nothing to"` ]]; then
    # Clean
    status_color="{green}"
  elif [[ -n `echo "${git_status}" | grep "^Untracked files"` ]]; then
    # Untracked file
    status_color="{red}?"
  elif [[ -n `echo "${git_status}" | grep "^Changes not staged for commit"` ]]; then
    # Unstaged file
    status_color="{red}+"
  elif [[ -n `echo "${git_status}" | grep "^Changes to be committed"` ]]; then
    # Uncommited file
    status_color="{yellow}!"
  elif [[ -n `echo "${git_status}" | grep "^rebase in progress"` ]]; then
    # Under confliction
    echo "{red}!(no branch)"
    return
  else
    # Normal
    status_color="{blue}"
  fi
  # Colorize branch name
  echo "%F${status_color}[${branch_name}]%f"
}

function python-venv-name() {
    if [ -n "${VIRTUAL_ENV}" ]; then
        echo " %F{yellow}<venv:$(basename ${VIRTUAL_ENV})>%f"
    fi
}

prompt () {
    PROMPT="%K{031}%n@%m%k %F{cyan}[%*]%f %B%F{cyan}%~%f%b$(python-venv-name)$(prompt-git-current-branch)
%F{white}%# %f"
}
precmd_functions+=(prompt)


################################################################################
# History
################################################################################
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.zsh_history
function histall() { history -E 1 }


################################################################################
# Key bindings
################################################################################
# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e
stty stop undef  # Disable tty stop by Ctrl-S

################################################################################
# Aliases
################################################################################
alias ls='ls --color=auto'
alias ll='ls -l'
alias now='date +%Y-%m-%d--%H-%M-%S'
alias today='date +%Y-%m-%d'
alias rpeo=repo
if [[ -x "${commands[colordiff]}" ]]; then
    alias diff="colordiff"
fi
alias jman='LANG=ja_JP.utf8 man'
alias OD='od -v -tx1z -Ax'


################################################################################
# Search file by name simply
################################################################################
alias findf='find . -name '


################################################################################
# zplug
################################################################################
if [ -d ${HOME}/.zplug ]; then
    export ZPLUG_HOME=${HOME}/.zplug
    source $ZPLUG_HOME/init.zsh

    zplug "b4b4r07/enhancd", use:init.sh
    zplug "zsh-users/zsh-syntax-highlighting", defer:2
    zplug "zsh-users/zsh-completions"

    if ! zplug check --verbose; then
        printf "Install? [y/N] "
        if read -q; then
            echo; zplug install
        fi
    fi
    zplug load
fi


################################################################################
# fzf
################################################################################
if (( $+commands[fzf] )); then
    export FZF_TMUX=1
    export FZF_TMUX_HEIGHT=30
    export FZF_DEFAULT_OPTS="--no-mouse --ansi --reverse --height 50% --multi"

    # fzf functions
    function fshow() {
        git log --graph --color=always \
            --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
            fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
                --bind "ctrl-m:execute:
                      (grep -o '[a-f0-9]\{7\}' | head -1 |
                      xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                      {}
FZF-EOF"
    }
fi

################################################################################
# Environments
################################################################################
export LESS='-R'  # R: ANSI color
export PATH="${HOME}/.local/bin:${PATH}"


################################################################################
# GNU Global
################################################################################
export GTAGSLABEL=pygments


################################################################################
# translate-shell
################################################################################
# https://github.com/soimort/translate-shell
# It is installed as below
#  $ wget git.io/trans
#  $ chmod +x ./trans

if (( $+commands[trans] )); then
    function ej() {
        trans en:ja "$*"
    }
    function je() {
        trans ja:en "$*"
    }
fi

################################################################################
# deepl-cli
################################################################################
# https://github.com/eggplants/deepl-cli/

if (( $+commands[deepl] )); then
    function dej() {
        echo $* | deepl en:ja
    }
    function dje() {
        echo $* | deepl ja:en
    }
fi


################################################################################
# mattn/memo
################################################################################
# https://teratail.com/questions/36536
if (( $+commands[memo] )); then
    alias m="memo"
fi


################################################################################
# Emacs
################################################################################
export EDITOR="emacs -nw"
function emacs() {
    start-emacs
    sleep 0.3
    emacsclient -t $@
}

function start-emacs() {
    if [[ 0 -eq $(ps aux | grep -i emacs | grep daemon | wc -l) ]]; then
        echo Starting emacs daemon
        $(whereis emacs | tr ' ' '\n' | grep bin | head -n 1) --daemon
        echo Done
    else
        echo Daemon already started
    fi
}

function kill-emacs() {
    if [[ 0 -ne $(ps aux | grep -i emacs | grep daemon | wc -l) ]]; then
        echo Killing emacs daemon
        emacsclient -e '(kill-emacs)'
        echo Done
    else
        echo No daemon started
    fi
}

function remacs() {
    kill-emacs && emacs
}


################################################################################
# bat
################################################################################
if (( $+commands[batcat] )); then
    alias bat=batcat
fi


################################################################################
# Android
################################################################################
export PATH=/opt/android-sdk/cmdline-tools/latest/bin:${PATH}
export ANDROID_SDK_ROOT=/opt/android-sdk


################################################################################
# pyenv
################################################################################
export PYENV_ROOT="${HOME}/.pyenv"
command -v pyenv > /dev/null || export PATH="${PYENV_ROOT}/bin:${PATH}"
eval "$(pyenv init -)"


################################################################################
# Local settings  (must be at the bottom of this file!)
################################################################################
if [[ -f "${HOME}/.zshrc.local" ]]; then
    source "${HOME}/.zshrc.local"
fi
