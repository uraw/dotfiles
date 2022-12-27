# -*- mode: Makefile -*-
EXCLUDES   := .git .emacs.d
CANDIDATES := $(wildcard .??*)
DOTFILES   := $(filter-out $(EXCLUDES), $(CANDIDATES))

all:

install:
	@$(foreach dotfile, $(DOTFILES), ln -sfnv $(abspath $(dotfile)) $(HOME)/$(dotfile);)
	@mkdir -p ~/.emacs.d
	@ln -sfnv $(abspath .emacs.d/init.el) ~/.emacs.d/init.el

clean:
	@echo 'Remove installed dot files...'
	@-$(foreach dotfile, $(DOTFILES), rm -vrf $(HOME)/$(dotfile);)
