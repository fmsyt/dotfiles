$promptLoaded = $false

$currentFileObject = Get-Item -Path $MyInvocation.MyCommand.path
if ($currentFileObject.Target) {
    $currentFileObject = Get-Item -Path $currentFileObject.Target
}
$realDir = Split-Path -Path $currentFileObject.FullName -Parent

if (where.exe starship) {
    $promptLoaded = $true

    $configPath = "$HOME\.config\starship-win.toml"
    $env:STARSHIP_CONFIG = $configPath

    Invoke-Expression (& starship init powershell)
}

if (!$promptLoaded -and (where.exe oh-my-posh)) {

    $jsonPath = "$realDir\slimfat.hook.omp.json"

    $fileObject = Get-Item -Path $jsonPath
    if ($fileObject.Target) {
        $jsonPath = $fileObject.Target
    }

    oh-my-posh init pwsh --config "$jsonPath" | Invoke-Expression

    $promptLoaded = $true
}


$env:AQUA_GLOBAL_CONFIG = "$HOME\.config\aquaproj-aqua\aqua.yaml"

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

function hist {
    $find = $args

    Get-Content (Get-PSReadlineOption).HistorySavePath
        | ForEach-Object { "$($_.ReadCount)  $_" }
        | Where-Object { $_ -like "*$find*" }
}

if (Get-Module -ListAvailable -Name Abbr) {
    Import-Module Abbr

    ealias g 'git'
    ealias gs 'git status'
    ealias gst 'git status'
    ealias ga 'git add'
    ealias ga. 'git add .'
    # ealias gc 'git commit'
    # ealias gp 'git push'
    ealias gco 'git checkout'

    ealias d 'docker'
    ealias de 'docker exec -it'

    ealias dc 'docker compose'
    ealias dce 'docker compose exec'
    ealias dcu 'docker compose up -d'
    ealias dcub 'docker compose up --build -d'

    ealias .. 'cd ..'
}

