################################################################################
# brew
################################################################################
if status is-interactive
    if test -e /opt/homebrew/bin/brew
        eval (/opt/homebrew/bin/brew shellenv)
    end
    if test -e /home/linuxbrew/.linuxbrew/bin/brew
        eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    end
end

################################################################################
# PATH
################################################################################
fish_add_path ~/.local/bin
fish_add_path $HOMEBREW_PREFIX/opt/openjdk/bin


################################################################################
# Shell customizing
################################################################################

# history
# https://qiita.com/yoshiori/items/f1c01dd94bb5f0489cf6
function history-merge --on-event fish_preexec
    history --save
    history --merge
end

# Aliases
alias ls 'ls --color=auto'
alias ll 'ls -l'
alias lll 'ls -l -D "%Y-%m-%d %H:%M" | rg -v / | fzf --preview="bat --color=always {-1}" --header-lines=1 --preview-window=down,border-top'
alias now 'date +%Y-%m-%d--%H-%M-%S'
alias today 'date +%Y-%m-%d'
if command -sq colordiff
    alias diff colordiff
end
alias jman 'LANG=ja_JP.utf8 man'
alias OD 'od -v -tx1z -Ax'

# Suppress greeting message
set -U fish_greeting ""


################################################################################
# Locale
################################################################################
set -Ux LANG en_US.UTF-8
set -Ux LC_CTYPE en_US.UTF-8


################################################################################
# Python
################################################################################

# pyenv
set -Ux PYENV_ROOT ~/.pyenv
fish_add_path $PYENV_ROOT/bin
pyenv init - | source

# venv
# Auto activate and deactivate venv
# https://gist.github.com/tommyip/cf9099fa6053e30247e5d0318de2fb9e
function __auto_activate_venv --on-variable PWD --description "Activate/Deactivate virtualenv on directory change"
    status --is-command-substitution; and return

    # Check if we are inside a git directory
    if git rev-parse --show-toplevel &>/dev/null
        set gitdir (realpath (git rev-parse --show-toplevel))
    else
        set gitdir "."
    end

    # If venv is not activated or a different venv is activated and venv exist.
    if test "$VIRTUAL_ENV" != "$gitdir/.venv" -a -e "$gitdir/.venv/bin/activate.fish"
        source $gitdir/.venv/bin/activate.fish
        # If venv activated but the current (git) dir has no venv.
    else if not test -z "$VIRTUAL_ENV" -o -e "$gitdir/.venv"
        deactivate
    end
end


################################################################################
# Emacs
################################################################################
set -Ux EDITOR "emacs"
function emacs
    start-emacs
    sleep 0.3
    emacsclient -t $argv
end

function is-emacs-daemon-running
    # Check if emacs daemon is running
    # Return value
    #   0 - emacs daemon is running
    #   Non-zero - emacs daemon is not runnig
    emacsclient -e "()" > /dev/null 2>&1
    return $status
end

function start-emacs
    if is-emacs-daemon-running
        echo Daemon already running
    else
        echo Starting emacs daemon
        eval (whereis emacs | tr ' ' '\n' | grep bin | head -n 1) --daemon
        echo Done
    end
end

function kill-emacs
    if is-emacs-daemon-running
        echo Killing emacs daemon
        emacsclient -e '(kill-emacs)'
        echo Done
    else
        echo No daemon running
    end
end

function remacs
    kill-emacs && emacs
end


################################################################################
# Android
################################################################################
fish_add_path /opt/android-sdk/cmdline-tools/latest/bin
set -Ux ANDROID_SDK_ROOT /opt/android-sdk


################################################################################
# Go lang
################################################################################
set -Ux GOPATH (go env GOPATH)
fish_add_path $GOPATH/bin


################################################################################
# Misc. tools
################################################################################

# ls color setting
set -Ux LSCOLORS gxfxcxdxbxegedabagacad

# fzf
if command -sq fzf
    set -Ux FZF_TMUX 1
    set -Ux FZF_TMUX_HEIGHT 30
    set -Ux FZF_DEFAULT_OPTS "--no-mouse --ansi --reverse --height 50% --multi"
end

# GNU Global
set -Ux GTAGSLABEL pygments

# translate-shell
if command -sq trans
    alias ej 'trans en:ja'
    alias je 'trans ja:en'
end

# deepl-cli
# https://github.com/eggplants/deepl-cli/
if command -sq deepl
    function dej
        echo $argv | deepl en:ja
    end
    function dje
        echo $argv | deepl ja:en
    end
end

# mattn/memo
# https://teratail.com/questions/36536
if command -sq memo
    alias m memo
end

# less
set -Ux LESS '-R'  # R: ANSI color

# bat
if command -sq batcat
    alias bat batcat
end

################################################################################
# Node
################################################################################
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH


################################################################################
# Local settings  (must be at the bottom of this file!)
################################################################################
if test -f ~/.config/fish/config.fish.local
    source ~/.config/fish/config.fish.local
end
