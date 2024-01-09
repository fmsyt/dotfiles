function ll() {
    Get-ChildItem -Exclude .* $args
}

function la() {
    Get-ChildItem $args
}

function open() {
    Invoke-Item $args
}
