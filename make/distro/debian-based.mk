PACKAGES += emacs git ripgrep hunspell hunspell-hu hunspell-en-gb hunspell-en-us

debian-update-repos :
	@sudo apt-get update -y

debian-upgrade : debian-update-repos
	@sudo apt-get upgrade -y

debian-install : debian-update-repos
	@sudo apt-get install -y $(PACKAGES)

ifndef INSTALL_FAST
BASE_TARGETS += debian-upgrade
endif

BASE_TARGETS += debian-install
