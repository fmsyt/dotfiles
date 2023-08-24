function ll() {
    Get-ChildItem -Exclude .* $args
}
function la() {
    Get-ChildItem $args
}
