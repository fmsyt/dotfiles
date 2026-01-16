function ide
    # $WEZTERM_EXECUTABLE が設定されていなければなにもしない
    if test -z "$WEZTERM_EXECUTABLE"
        echo "ide: WEZTERM_EXECUTABLE is not set"
        return 1
    end

    command wezterm cli split-pane --right
    command wezterm cli split-pane --bottom
    command wezterm cli activate-pane --pane-id $WEZTERM_PANE
end
