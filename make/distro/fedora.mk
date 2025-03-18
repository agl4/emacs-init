PACKAGES += emacs git hunspell hunspell-hu hunspell-en-GB hunspell-en-US ripgrep

fedora-upgrade :
	@sudo dnf upgrade -y

fedora-install :
	@sudo dnf install -y $(PACKAGES)

ifndef INSTALL_FAST
BASE_TARGETS += fedora-upgrade
endif

BASE_TARGETS += fedora-install
