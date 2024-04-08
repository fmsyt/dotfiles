function git-diff-archive

    if ! test -f $DOTFILES_DIR"/scripts/git-diff-archive.sh"
        echo "git-diff-archive.sh not found"
        return 1
    end

    command bash $DOTFILES_DIR"/scripts/git-diff-archive.sh" $argv
end
