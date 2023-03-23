Set-Alias wget Invoke-WebRequest

function ll() {
    Get-ChildItem -Exclude .* $args
}
function la() {
    Get-ChildItem $args
}
