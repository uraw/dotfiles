# -*- mode: Makefile -*-
EXCLUDES   := .git .emacs.d
CANDIDATES := $(wildcard .??*)
DOTFILES   := $(filter-out $(EXCLUDES), $(CANDIDATES))

all:

install:
	@$(foreach dotfile, $(DOTFILES), ln -sfnv $(abspath $(dotfile)) $(HOME)/$(dotfile);)
	@mkdir -p ~/.emacs.d
	@ln -sfnv $(abspath .emacs.d/init.el) ~/.emacs.d/init.el
	@mkdir -p ~/.config/fish
	@ln -sfnv $(abspath .config/fish/config.fish) ~/.config/fish/config.fish

	@mkdir -p ~/.ipython
	@ln -sfnv $(abspath ipython_config.py) ~/.ipython/profile_default/

clean:
	@echo 'Remove installed dot files...'
	@-$(foreach dotfile, $(DOTFILES), rm -vrf $(HOME)/$(dotfile);)
