DOTFILES_DIR := $(shell pwd)
HOME_DIR := $(HOME)

FILES_ALL := $(shell find $(DOTFILES_DIR) -mindepth 1 -maxdepth 1 -name '.[!git]*' -printf '%f\n')

all: full

full:
	@echo $(FILES_ALL)
	@$(MAKE) install FILES="$(FILES_ALL)"

install:
	@echo "Installing dotfiles..."
	@for file in $(FILES); do \
		echo "Linking $$file"; \
		ln -sf $(DOTFILES_DIR)/$$file $(HOME_DIR)/$$file; \
	done
