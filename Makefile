# -*- mode: Makefile -*-
.PHONY: emacs fish git python tmux vim zsh

all:

install: emacs fish git python tmux vim zsh
	@echo install

emacs:
	@mkdir -p ~/.emacs.d
	@ln -sfnv $(abspath emacs/init.el) ~/.emacs.d/init.el

fish:
	@mkdir -p ~/.config/fish
	@ln -sfnv $(abspath fish/config.fish) ~/.config/fish/config.fish

git:
	@ln -sfnv $(abspath git/.gitconfig) ~/.gitconfig

python:
	@ln -sfnv $(abspath python/.flake8) ~/.flake8
	@mkdir -p ~/.ipython/profile_default
	@ln -sfnv $(abspath ipython_config.py) ~/.ipython/profile_default/ipython_config.py

tmux:
	@ln -sfnv $(abspath tmux/.tmux.conf) ~/.tmux.conf

vim:
	@ln -sfnv $(abspath vim/.vimrc) ~/.vimrc

zsh:
	@ln -sfnv $(abspath zsh/.zshrc) ~/.zshrc
	@ln -sfnv $(abspath zsh/.zlogin) ~/.zlogin

uninstall:
	@echo 'Remove installed dot files...'
	@-rm -v ~/.emacs.d/init.el
	@-rm -v ~/.config/fish/config.fish
	@-rm -v ~/.gitconfig
	@-rm -v ~/.flake8
	@-rm -v ~/.ipython/profile_default/ipython_config.py
	@-rm -v ~/.tmux.conf
	@-rm -v ~/.vimrc
	@-rm -v ~/.zshrc
	@-rm -v ~/.zlogin
