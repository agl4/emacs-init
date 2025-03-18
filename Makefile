#
# Source for configs:
#
# - https://makefiletutorial.com/#makefile-cookbook
# - https://lunarwatcher.github.io/posts/2024/01/06/how-to-set-up-a-makefile-for-managing-dotfiles-and-system-configurations.html
# - https://polothy.github.io/post/2018-10-09-makefile-dotfiles/
# - https://github.com/masasam/dotfiles/blob/master/Makefile
#
.PHONY : apps caps-lock dev directories server desktop install base test

SHELL := /bin/bash
OS := $(shell uname -s)
ARCHITECTURE := $(shell uname -m)
ifeq ($(OS),Linux)
DISTRIBUTION := $(shell source /etc/os-release && echo "$$ID")
VERSION_CODENAME := $(shell cat /etc/os-release | sed -n 's/^VERSION_CODENAME=\(.*\)$$/\1/p')
endif
SRCDIR := ./src
PREFIX ?= ${HOME}/.local/bin







EMACS_CHEMACS_CONFIGS := .emacs-profile .emacs-profiles.el

# Install files from source directory to home directory
$(HOME)/%: chemacs-profiles/%
	@install -m 0600 -v $< $@

# Target for chemacs configurations
chemacs_configs: $(addprefix $(HOME)/, $(EMACS_CHEMACS_CONFIGS))

# Clone chemacs2 repository if not already present
$(HOME)/.emacs.d: chemacs_configs
	@git clone https://github.com/plexus/chemacs2 $@ || echo "Skipping chemacs installation"


# INSIDE_DOCKER := $(or $(and $(wildcard /.dockerenv),1),0)
ifneq ($(wildcard /.dockerenv),)
    # .dockerenv file exists
    INSIDE_DOCKER := 1
else
    # .dockerenv file does not exist
    # INSIDE_DOCKER remains undefined
endif





HOST := $(shell hostname)
# Debug information
$(info -- Running on host.........: $(HOST))
$(info -- Detected OS.............: $(OS))
$(info -- Detected distribution...: $(DISTRIBUTION))
$(info -- Version codename .......: $(VERSION_CODENAME))
$(info -- Architecture ...........: $(ARCHITECTURE))
$(info -- Inside docker ..........: $(INSIDE_DOCKER))

# Target definitions
BASE_TARGETS :=
PACKAGES = curl fish git tmux

# ... other variable declarations
-include make/os/$(OS).mk
-include make/distro/$(DISTRIBUTION).mk

install: $(HOME)/.emacs.d $(BASE_TARGETS)
