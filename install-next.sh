#!/bin/sh
set -ue

VERBOSE=${VERBOSE:-0}

ORANGE="\033[0;33m"
NC="\033[0m"

PID=$$
CP_BACKUP_SUFFIX=${CP_BACKUP_SUFFIX:-".bak.$PID"}

if [ -z "$HOME" ]; then
  echo "ERROR: HOME environment variable is not set."
  exit 1
fi

VERBOSE_PREFIX="${ORANGE}[VERBOSE]${NC}"
vprintf() {
  if [ "$VERBOSE" -eq 0 ]; then
    return
  fi
  echo "$VERBOSE_PREFIX $1"
}

helpmsg() {
  echo "Usage: $0"
  echo "Options:"
  echo "  -d, --debug     Print debug information"
  echo "  -h, --help      Print this message"
  echo "  -v, --verbose   Print verbose information"
}

DOTFILES_DIR="$(cd "$(dirname "${0}")" && pwd -P)"
BACKUP_DIR="$HOME/.dotbackup"

#
# usage: cpdir <source_dir> <destination_dir>
#
cpdir() {

  src_dir="$1"
  dst_dir="$2"

  cp -r --backup="$CP_BACKUP_SUFFIX" "$src_dir/"* "$dst_dir/"
  cp -r --backup="$CP_BACKUP_SUFFIX" "$src_dir/".* "$dst_dir/" 2>/dev/null || true

  find "$dst_dir" -name "*$CP_BACKUP_SUFFIX" | while IFS= read -r backup_file; do
    original_file="${backup_file%"$CP_BACKUP_SUFFIX"}"
    vprintf "$VERBOSE_PREFIX Backup $original_file to $BACKUP_DIR"

    file_dir=$(dirname "${original_file#"$dst_dir"/}")
    src_basename=$(basename "$src_dir")
    mkdir -p "$BACKUP_DIR/$src_basename/$file_dir"
    mv "$backup_file" "$BACKUP_DIR/$src_basename/$file_dir/"

    # Restore original file
    mv "$original_file$CP_BACKUP_SUFFIX" "$original_file"
  done
}

install() {

  target_path="$1"
  target_basename=$(basename "$target_path")

  if [ -z "$target_basename" ]; then
    return
  fi

  case "$target_basename" in
  .git*) return ;;
  esac

  # is symbolic link
  if [ -L "$HOME/$target_basename" ]; then
    unlink "$HOME/$target_basename"

  # is directory
  elif [ -d "$HOME/$target_basename" ]; then
    cpdir "$target_path" "$HOME/$target_basename"
    rm -rf "$target_path"
    mv "$HOME/$target_basename" "$target_path"

  # is file
  elif [ -f "$HOME/$target_basename" ]; then
    mkdir -p "$BACKUP_DIR"
    mv "$HOME/$target_basename" "$BACKUP_DIR"
  fi

  ln -snf "$target_path" "$HOME/$target_basename"
}

post_install() {
  git config --global include.path "$DOTFILES_DIR/.gitconfig"

  if [ -z "$(ls -A "$BACKUP_DIR")" ]; then
    rmdir "$BACKUP_DIR"
  else
    echo "Current dotfiles are evacuated to $BACKUP_DIR"
  fi

  echo "${ORANGE}Dotfiles installation is complete!${NC}"
}

main() {
  if [ ! -d "$BACKUP_DIR" ]; then
    mkdir "$BACKUP_DIR"
  fi

  if [ "$HOME" = "$DOTFILES_DIR" ]; then
    echo "dotfiles are already installed."
    exit 1
  fi

  find "$DOTFILES_DIR" -maxdepth 1 -mindepth 1 -name ".*" | while read -r target_path; do
    target_basename=$(basename "$target_path")
    case "$target_basename" in
    .git*) continue ;;
    esac

    vprintf "Processing dotdir: $target_path"
    install "$target_path"
  done

  post_install
}

while [ $# -gt 0 ]; do
  case ${1} in
  --debug | -d)
    set -uex
    shift
    ;;
  --help | -h)
    helpmsg
    exit 1
    ;;
  --verbose | -v)
    VERBOSE=1
    shift
    ;;
  *)
    shift
    ;;
  esac
done

main
