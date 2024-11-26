DOTFILES_DIR := $(shell realpath $(PWD))
HOME_DIR := $(HOME)

FILES_ALL := $(shell find $(DOTFILES_DIR) -mindepth 1 -maxdepth 1 -name '.[!git]*' -printf '%f\n')
FILES_MIN := '.config' '.local'

all: help

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  full              Install all dotfiles"
	@echo "  minimal           Install minimal dotfiles"
	@echo "  min               Alias for minimal"
	@echo "  post_install      Post install tasks"
	@echo "  help              Show this help message"

full:
	@$(MAKE) install FILES="$(FILES_ALL)"
	@$(MAKE) post_install

min:
	@$(MAKE) minimal

minimal:
	@$(MAKE) install FILES="$(FILES_MIN)"

install:
	@if [ -z "$(FILES)" ]; then \
		echo "No files to install"; \
		exit 1; \
	fi
	@echo "Installing dotfiles..."
	@mkdir -p $(HOME_DIR)/.dotbackup
	@for file in $(FILES); do \
		echo "Linking $$file"; \
		[ -d $(HOME_DIR)/$$file ] && mv $(HOME_DIR)/$$file $(HOME_DIR)/.dotbackup/; \
		ln -s $(DOTFILES_DIR)/$$file $(HOME_DIR)/ --backup=numbered; \
	done

post_install:
	@echo "Post install tasks..."
	@echo "$(DOTFILES_DIR)/.gitconfig"
	@git config --global include.path "$(DOTFILES_DIR)/.gitconfig"
