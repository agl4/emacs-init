UNAME_M := $(shell uname -m)
BREW := /opt/homebrew/bin/brew
ifeq ($(UNAME_M),x86_64)
BREW := /usr/local/bin/brew
endif

PACKAGES += sqlite3 ripgrep hunspell
PACKAGES_CASKS := emacs

darwin-brew-update :
	@${BREW} update

darwin-brew-upgrade :
	@${BREW} update

darwin-base :
	@${BREW} install $(PACKAGES)
	@${BREW} install --cask $(PACKAGES_CASKS)

hunspell_install_dictionaries:
	@bash share/darwin-install-hunspell-dictionaries.sh

ifndef INSTALL_FAST
BASE_TARGETS += darwin-brew-update
BASE_TARGETS += darwin-brew-upgrade
endif
BASE_TARGETS += darwin-base
BASE_TARGETS += hunspell_install_dictionaries
