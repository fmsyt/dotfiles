DOTFILES_DIR := $(shell realpath $(PWD))
HOME_DIR := $(HOME)

FILES_ALL := $(shell find $(DOTFILES_DIR) -mindepth 1 -maxdepth 1 -name '.[!git]*' -printf '%f\n')
FILES_MIN := '.config' '.local'

SSH_SHARED_CONFIG_DIR := $(HOME_DIR)/.ssh/shared
SSH_INCLUDE_DIRECTIVE := Include $(SSH_SHARED_CONFIG_DIR)/*.conf
SSH_CONFIG_FILE := $(HOME_DIR)/.ssh/config

TEST_DIR := $(DOTFILES_DIR)/test

VERBOSE ?= 0

ifeq ($(VERBOSE), 1)
	Q =
else
	Q = @
endif

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
	@$(MAKE) install FILES="$(FILES_ALL)" DIST_DIR="$(HOME_DIR)"
	@$(MAKE) post_install
	@$(MAKE) post_ssh_install

min:
	@$(MAKE) minimal

minimal:
	@$(MAKE) install FILES="$(FILES_MIN)" DIST_DIR="$(HOME_DIR)"

install:
	$(Q)echo "FILES: $(FILES)"
	$(Q)echo "DIST_DIR: $(DIST_DIR)"
	$(Q)echo "DOTFILES_DIR: $(DOTFILES_DIR)"
	@echo "\e[1;33mInstalling dotfiles...\e[0m"
	@mkdir -p $(DIST_DIR)/.dotbackup
	@# Install dotfiles
	@for file in $(FILES); do \
		echo "\e[1;32mLinking: $$file\e[0m"; \
		[ -d $(DIST_DIR)/$$file ] && rsync -alr --ignore-existing --remove-source-files $(DIST_DIR)/$$file/* $(DOTFILES_DIR)/$$file; \
		[ -e $(DIST_DIR)/$$file ] && mv $(DIST_DIR)/$$file $(DIST_DIR)/.dotbackup/; \
		ln -s $(DOTFILES_DIR)/$$file $(DIST_DIR)/; \
	done

post_install:
	@echo "Post install tasks..."
	@echo "$(DOTFILES_DIR)/.gitconfig"
	@git config --global include.path "$(DOTFILES_DIR)/.gitconfig"

post_ssh_install:
	@echo "Post SSH install tasks..."
	@touch $(SSH_CONFIG_FILE)
	@if grep -F -q $(SSH_INCLUDE_DIRECTIVE) $(SSH_CONFIG_FILE); then \
		echo "SSH include directive already exists"; \
	else \
		echo "Adding SSH include directive"; \
		sed -i "1s;^;$(SSH_INCLUDE_DIRECTIVE)\n;" $(SSH_CONFIG_FILE); \
	fi
	@if [ $(shell find $(SSH_SHARED_CONFIG_DIR) -type f | grep -E *.conf | wc -l) -gt 0 ]; then \
		chmod 600 $(SSH_SHARED_CONFIG_DIR)/*.conf; \
	fi

test:
	@if [ -d $(TEST_DIR) ]; then \
		rm -rf $(TEST_DIR); \
	fi
	@mkdir -p $(TEST_DIR)
	@echo "tmp: $(TEST_DIR)"
	@# Create test files as local files
	@mkdir -p $(TEST_DIR)/test_dir_a/sub_dir_a
	@mkdir -p $(TEST_DIR)/test_dir_a/sub_dir_b
	@mkdir -p $(TEST_DIR)/test_dir_b/sub_dir_a
	@mkdir -p $(TEST_DIR)/test_dir_b/sub_dir_b
	@# Create test files as dotfiles
	@mkdir -p $(TEST_DIR)/dotfiles/test_dir_a/sub_dir_a
	@mkdir -p $(TEST_DIR)/dotfiles/test_dir_a/sub_dir_c
	@mkdir -p $(TEST_DIR)/dotfiles/test_dir_c/sub_dir_a
	@mkdir -p $(TEST_DIR)/dotfiles/test_dir_c/sub_dir_c
	@# Create test files in local
	@echo "local backup" > $(TEST_DIR)/file_1
	@echo "local keep"   > $(TEST_DIR)/file_2
	@echo "local backup" > $(TEST_DIR)/test_dir_a/file_1
	@echo "local keep"   > $(TEST_DIR)/test_dir_a/file_2
	@echo "local backup" > $(TEST_DIR)/test_dir_a/sub_dir_a/file_1
	@echo "local keep"   > $(TEST_DIR)/test_dir_a/sub_dir_a/file_2
	@echo "local keep"   > $(TEST_DIR)/test_dir_a/sub_dir_b/file_1
	@echo "local keep"   > $(TEST_DIR)/test_dir_a/sub_dir_b/file_2
	@echo "local keep"   > $(TEST_DIR)/test_dir_b/file_1
	@echo "local keep"   > $(TEST_DIR)/test_dir_b/file_2
	@echo "local keep"   > $(TEST_DIR)/test_dir_b/sub_dir_a/file_1
	@echo "local keep"   > $(TEST_DIR)/test_dir_b/sub_dir_a/file_2
	@echo "local keep"   > $(TEST_DIR)/test_dir_b/sub_dir_b/file_1
	@echo "local keep"   > $(TEST_DIR)/test_dir_b/sub_dir_b/file_2
	@# Create test files in dotfiles
	@echo "dotfiles keep"   > $(TEST_DIR)/dotfiles/file_1
	@echo "dotfiles keep"   > $(TEST_DIR)/dotfiles/file_3
	@echo "dotfiles keep"   > $(TEST_DIR)/dotfiles/test_dir_a/file_1
	@echo "dotfiles keep"   > $(TEST_DIR)/dotfiles/test_dir_a/file_3
	@echo "dotfiles keep"   > $(TEST_DIR)/dotfiles/test_dir_a/sub_dir_a/file_1
	@echo "dotfiles keep"   > $(TEST_DIR)/dotfiles/test_dir_a/sub_dir_a/file_3
	@echo "dotfiles keep"   > $(TEST_DIR)/dotfiles/test_dir_a/sub_dir_c/file_1
	@echo "dotfiles keep"   > $(TEST_DIR)/dotfiles/test_dir_a/sub_dir_c/file_3
	@echo "dotfiles keep"   > $(TEST_DIR)/dotfiles/test_dir_c/file_1
	@echo "dotfiles keep"   > $(TEST_DIR)/dotfiles/test_dir_c/file_3
	@echo "dotfiles keep"   > $(TEST_DIR)/dotfiles/test_dir_c/sub_dir_a/file_1
	@echo "dotfiles keep"   > $(TEST_DIR)/dotfiles/test_dir_c/sub_dir_a/file_3
	@echo "dotfiles keep"   > $(TEST_DIR)/dotfiles/test_dir_c/sub_dir_c/file_1
	@echo "dotfiles keep"   > $(TEST_DIR)/dotfiles/test_dir_c/sub_dir_c/file_3
	$(Q)tree -a $(TEST_DIR)
	@find $(TEST_DIR) -type f | xargs cat | grep "keep" | wc -l
	@echo "Files to install:"
	@$(MAKE) install \
		VERBOSE=1 \
		FILES="$(shell find $(TEST_DIR)/dotfiles -mindepth 1 -maxdepth 1 -printf '%f\n')" \
		DIST_DIR="$(TEST_DIR)" \
		DOTFILES_DIR="$(TEST_DIR)/dotfiles"
	@tree -a $(TEST_DIR)
	@find $(TEST_DIR) -type f | xargs grep -H "" | sort
	@find $(TEST_DIR) -type f | xargs cat | grep "keep" | wc -l
	@rm -rf $(TEST_DIR)

.PHONY: all help full minimal min install post_install post_ssh_install test
