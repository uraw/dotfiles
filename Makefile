# -*- mode: Makefile -*-
.PHONY: emacs fish git python tmux vim zsh

all:

install: emacs fish git python tmux vim zsh
	@echo install

emacs:
	@mkdir -p ~/.emacs.d
	@ln -sfnv $(abspath emacs/init.el) ~/.emacs.d/

fish:
	@mkdir -p ~/.config/fish/functions
	@ln -sfnv $(abspath fish/config.fish)             ~/.config/fish/
	@ln -sfnv $(abspath fish/fish_prompt.fish)        ~/.config/fish/functions/
	@ln -sfnv $(abspath fish/fish_right_prompt.fish)  ~/.config/fish/functions/
	@ln -sfnv $(abspath fish/__auto_source_venv.fish) ~/.config/fish/functions/

git:
	@ln -sfnv $(abspath git/.gitconfig) ~/

python:
	@mkdir -p ~/.ipython/profile_default
	@ln -sfnv $(abspath ipython_config.py) ~/.ipython/profile_default
	@ln -sfnv $(abspath python/.flake8)    ~/

tmux:
	@ln -sfnv $(abspath tmux/.tmux.conf) ~/

vim:
	@ln -sfnv $(abspath vim/.vimrc) ~/

zsh:
	@ln -sfnv $(abspath zsh/.zshrc)  ~/
	@ln -sfnv $(abspath zsh/.zlogin) ~/

uninstall:
	@echo 'Remove installed dot files...'
	@-rm -v ~/.emacs.d/init.el
	@-rm -v ~/.config/fish/config.fish
	@-rm -v ~/.config/fish/functions/fish_prompr.fish
	@-rm -v ~/.config/fish/functions/fish_right_prompr.fish
	@-rm -v ~/.config/fish/functions/__auto_source_venv.fish
	@-rm -v ~/.gitconfig
	@-rm -v ~/.flake8
	@-rm -v ~/.ipython/profile_default/ipython_config.py
	@-rm -v ~/.tmux.conf
	@-rm -v ~/.vimrc
	@-rm -v ~/.zshrc
	@-rm -v ~/.zlogin
