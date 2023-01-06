if status is-interactive
    # Commands to run in interactive sessions can go here

    ################################################################################
    # brew
    ################################################################################
    if test -e /opt/homebrew/bin/brew
        eval (/opt/homebrew/bin/brew shellenv)
    end
end

################################################################################
# pyenv
################################################################################
set -Ux PYENV_ROOT ~/.pyenv
fish_add_path $PYENV_ROOT/bin

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
# Fix SSH_AUTH_SOCK for tmux
################################################################################
# cf. http://www.gcd.org/blog/2006/09/100/
# cf. https://qiita.com/isaoshimizu/items/84ac5a0b1d42b9d355cf
set agent ~/.ssh-agent-$USER
if test -S "{$SSH_AUTH_SOCK}"
    switch {$SSH_AUTH_SOCK}
    case /tmp/*/agent.[0-9]*
        ln -snf "{$SSH_AUTH_SOCK}" "{$agent}" && export SSH_AUTH_SOCK=$agent
    end
else if test -S $agent
    set -Ux SSH_AUTH_SOCK $agent
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

function restart-emacs
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
fish_add_path ~/tools/platform-tools
fish_add_path ~/tools/android-ndk-r16b


################################################################################
# Rust
################################################################################
if test -d ~/.cargo
    fish_add_path ~/.cargo/bin
end

################################################################################
# Twitter API
################################################################################
if test -f ~/.config/auth/twitter_api.toml
    if command -sq toml
        set -Ux TWITTER_BEARER_TOKEN (toml get --toml-path ~/.config/auth/twitter_api.toml BEARER_TOKEN)
    end
end

################################################################################
# Local settings  (must be at the bottom of this file!)
################################################################################
if test -f ~/.zshrc_local
    source ~/.zshrc_local
end
