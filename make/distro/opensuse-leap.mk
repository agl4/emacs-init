PACKAGES += hunspell emacs ripgrep

opensuse-tumbleweed-upgrade :
	@sudo zypper update -y

opensuse-tumbleweed-install :
	@sudo zypper install -y $(PACKAGES)

ifndef INSTALL_FAST
BASE_TARGETS += opensuse-tumbleweed-upgrade
endif

BASE_TARGETS += opensuse-tumbleweed-install
