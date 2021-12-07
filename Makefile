# -*- mode: Makefile -*-
EXCLUDES   := .git
CANDIDATES := $(wildcard .??*)
DOTFILES   := $(filter-out $(EXCLUDES), $(CANDIDATES))

all:

install:
	@$(foreach dotfile, $(DOTFILES), ln -sfnv $(abspath $(dotfile)) $(HOME)/$(dotfile);)

clean:
	@echo 'Remove installed dot files...'
	@-$(foreach dotfile, $(DOTFILES), rm -vrf $(HOME)/$(dotfile);)
