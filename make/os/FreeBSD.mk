.PHONY : freebsd-pkg-update freebsd-pkg-upgrade freebsd-base

PACKAGES += emacs hunspell en-hunspell hu-hunspell

freebsd-pkg-update :
	@pkg update -f

freebsd-base : freebsd-pkg-update
	@pkg install -y $(PACKAGES)

BASE_TARGETS += freebsd-base
