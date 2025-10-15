if not command -v go >/dev/null 2>&1
    exit
end

set -gx GOPATH $HOME/go
set -gx GOROOT (go env GOROOT)
set -gx PATH $GOPATH/bin $GOROOT/bin $PATH
