$promptLoaded = $false

$realDir = Split-Path -Path $currentFileObject.FullName -Parent

if (where.exe starship) {
    $promptLoaded = $true
    Invoke-Expression (& starship init powershell)
}

if (!$promptLoaded -and (where.exe oh-my-posh)) {

    $currentFileObject = Get-Item -Path $MyInvocation.MyCommand.path
    if ($currentFileObject.Target) {
        $currentFileObject = Get-Item -Path $currentFileObject.Target
    }

    $jsonPath = "$realDir\slimfat.hook.omp.json"

    $fileObject = Get-Item -Path $jsonPath
    if ($fileObject.Target) {
        $jsonPath = $fileObject.Target
    }

    oh-my-posh init pwsh --config "$jsonPath" | Invoke-Expression

    $promptLoaded = $true
}

# ./local.ps1 is exists, source it
$localPath = "$realDir\local.ps1"
if (Test-Path -Path $localPath) {
    . $localPath
}

function ll() {
    Get-ChildItem -Exclude .* $args
}

function la() {
    Get-ChildItem $args
}

function open() {
    Param (
        [Parameter(Mandatory = $true)]
        [string]$args,
        [string]$app = "start"
    )
    cmd.exe /u /q /c $app $args
}
