#
# Source for configs:
#
# - https://makefiletutorial.com/#makefile-cookbook
# - https://lunarwatcher.github.io/posts/2024/01/06/how-to-set-up-a-makefile-for-managing-dotfiles-and-system-configurations.html
# - https://polothy.github.io/post/2018-10-09-makefile-dotfiles/
# - https://github.com/masasam/dotfiles/blob/master/Makefile
#
.PHONY : install all

SHELL := /bin/bash
OS := $(shell uname -s)
ifeq ($(OS),Linux)
DISTRIBUTION := $(shell source /etc/os-release && echo "$$ID")
VERSION_CODENAME := $(shell cat /etc/os-release | sed -n 's/^VERSION_CODENAME=\(.*\)$$/\1/p')
endif

# Target definitions
BASE_TARGETS :=
PACKAGES = curl fish git tmux

# ... other variable declarations
-include make/os/$(OS).mk
-include make/distro/$(DISTRIBUTION).mk
include make/chemacs.mk

install : $(BASE_TARGETS) chemacs
all : install
