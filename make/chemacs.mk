.PHONY : checkout-repos chemacs
EMACS_CHEMACS_CONFIGS := .emacs-profile .emacs-profiles.el

# Install files from source directory to home directory
$(HOME)/%: share/chemacs-profiles/%
	@install -m 0600 -v $< $@

# Target for chemacs configurations
chemacs_configs: $(addprefix $(HOME)/, $(EMACS_CHEMACS_CONFIGS))

# Clone chemacs2 repository if not already present
$(HOME)/.emacs.d: chemacs_configs
	@git clone https://github.com/plexus/chemacs2 $@ || echo "Skipping chemacs installation"

# Make sure these repos are in sync with the configuration in
# share/chemacs-profiles
checkout-repos :
	@git clone https://github.com/agl4/emacs-emacs.d "${HOME}/src/emacs/agl4/emacs-emacs.d" || true
	@git clone https://github.com/doomemacs/doomemacs "${HOME}/src/emacs/hlissner/doom-emacs" || true
	@git clone https://github.com/syl20bnr/spacemacs "${HOME}/src/emacs/syl20bnr/spacemacs" || true

chemacs: $(HOME)/.emacs.d checkout-repos
