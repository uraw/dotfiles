if status is-interactive
    # Commands to run in interactive sessions can go here

    ################################################################################
    # brew
    ################################################################################
    if test -e /opt/homebrew/bin/brew
        eval (/opt/homebrew/bin/brew shellenv)
    end
    if test -e /home/linuxbrew/.linuxbrew/bin/brew
        eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    end
end


################################################################################
# Language
################################################################################
set -Ux LANG en_US.UTF-8
set -Ux LC_CTYPE en_US.UTF-8


################################################################################
# History
################################################################################
# https://qiita.com/yoshiori/items/f1c01dd94bb5f0489cf6
function history-merge --on-event fish_preexec
    history --save
    history --merge
end


################################################################################
# Aliases
################################################################################
alias ls 'ls --color=auto'
alias ll 'ls -l'
alias now 'date +%Y-%m-%d--%H-%M-%S'
alias today 'date +%Y-%m-%d'
if command -sq colordiff
    alias diff colordiff
end
alias jman 'LANG=ja_JP.utf8 man'
alias OD 'od -v -tx1z -Ax'


################################################################################
# fzf
################################################################################
if command -sq fzf
    set -Ux FZF_TMUX 1
    set -Ux FZF_TMUX_HEIGHT 30
    set -Ux FZF_DEFAULT_OPTS "--no-mouse --ansi --reverse --height 50% --multi"
end

################################################################################
# Other Environments
################################################################################
set -Ux LESS '-R'  # R: ANSI color
fish_add_path ~/.local/bin


################################################################################
# GNU Global
################################################################################
set -Ux GTAGSLABEL pygments


################################################################################
# translate-shell
################################################################################
if command -sq trans
    alias ej 'trans en:ja'
    alias je 'trans ja:en'
end

################################################################################
# deepl-cli
################################################################################
# https://github.com/eggplants/deepl-cli/

if command -sq deepl
    function dej
        echo $argv | deepl en:ja
    end
    function dje
        echo $argv | deepl ja:en
    end
end



################################################################################
# mattn/memo
################################################################################
# https://teratail.com/questions/36536
if command -sq memo
    alias m memo
end


################################################################################
# Emacs
################################################################################
set -Ux EDITOR "emacs -nw"
function emacs
    start-emacs
    sleep 0.3
    emacsclient -t $argv
end

function start-emacs
    if test (ps aux | grep -i emacs | grep daemon | wc -l) = 0
        echo Starting emacs daemon
        eval (whereis emacs | tr ' ' '\n' | grep bin | head -n 1) --daemon
        echo Done
    else
        echo Daemon already started
    end
end

function kill-emacs
    if test (ps aux | grep -i emacs | grep daemon | wc -l) != 0
        echo Killing emacs daemon
        emacsclient -e '(kill-emacs)'
        echo Done
    else
        echo No daemon started
    end
end

function remacs
    kill-emacs && emacs
end


################################################################################
# bat
################################################################################
if command -sq batcat
    alias bat batcat
end


################################################################################
# Android
################################################################################
fish_add_path /opt/android-sdk/cmdline-tools/latest/bin
set -Ux ANDROID_SDK_ROOT /opt/android-sdk



################################################################################
# pyenv
################################################################################
set -Ux PYENV_ROOT ~/.pyenv
fish_add_path $PYENV_ROOT/bin


################################################################################
# Local settings  (must be at the bottom of this file!)
################################################################################
if test -f ~/.config/fish/config.fish.local
    source ~/.config/fish/config.fish.local
end
