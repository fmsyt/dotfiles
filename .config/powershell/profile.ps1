$promptLoaded = $false

$currentFileObject = Get-Item -Path $MyInvocation.MyCommand.path
if ($currentFileObject.Target) {
    $currentFileObject = Get-Item -Path $currentFileObject.Target
}
$realDir = Split-Path -Path $currentFileObject.FullName -Parent

# $env:AQUA_GLOBAL_CONFIG = "$HOME\.config\aquaproj-aqua\aqua.yaml"
# Set-Item Env:Path "$Env:LOCALAPPDATA\aquaproj-aqua\bin;$Env:Path"

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
    Get-Content (Get-PSReadlineOption).HistorySavePath | ForEach-Object { "$($_.ReadCount)  $_" } | Where-Object { $_ -like "*$find*" }
}

function time {
  Invoke-Expression "Measure-Command { $args }"
}

function clip {
    <#
    .SYNOPSIS
        Copy a file or standard input via OSC 52
    .DESCRIPTION
        Copies FILE, or standard input when FILE is omitted or is -, to the
        terminal clipboard using OSC 52. Input piped into the function
        (COMMAND | clip) is used when FILE is omitted.
    .EXAMPLE
        clip README.md
    .EXAMPLE
        git diff | clip
    #>
    [CmdletBinding()]
    param (
        [Parameter(Position = 0)]
        [string]$File,

        [Parameter(ValueFromPipeline)]
        [string]$Line,

        [Parameter(ValueFromRemainingArguments)]
        [string[]]$Rest,

        [Alias('h')]
        [switch]$Help
    )

    begin {
        $lines = [System.Collections.Generic.List[string]]::new()
    }

    process {
        # The process block also runs once when there is no pipeline input, so
        # only count values that were actually bound from the pipeline.
        if ($PSBoundParameters.ContainsKey('Line')) {
            $lines.Add($Line)
        }
    }

    end {
        if ($Help -or ($Rest -contains '--help')) {
            Write-Host 'Usage: clip [FILE]'
            Write-Host '       COMMAND | clip'
            Write-Host ''
            Write-Host 'Copy FILE, or standard input when FILE is omitted or is -, to the'
            Write-Host 'terminal clipboard using OSC 52.'
            return
        }

        if ($Rest) {
            Write-Error 'clip: expected at most one file'
            return
        }

        if ($File -and $File -ne '-') {
            if (-not (Test-Path -Path $File -PathType Leaf)) {
                Write-Error "clip: cannot read file: $File"
                return
            }
            try {
                $bytes = [System.IO.File]::ReadAllBytes($File)
            }
            catch {
                Write-Error "clip: cannot read file: $File"
                return
            }
        }
        elseif ($lines.Count) {
            $bytes = [System.Text.Encoding]::UTF8.GetBytes($lines -join "`n")
        }
        elseif ([System.Console]::IsInputRedirected) {
            try {
                $stream = [System.IO.MemoryStream]::new()
                [System.Console]::OpenStandardInput().CopyTo($stream)
                $bytes = $stream.ToArray()
            }
            catch {
                Write-Error 'clip: cannot read standard input'
                return
            }
        }
        else {
            Write-Error 'clip: no input: give a file or pipe data into clip'
            return
        }

        $encoded = [System.Convert]::ToBase64String($bytes)

        # tmux requires escape sequences to be wrapped in a DCS passthrough.
        $esc = [string][char]27
        $bel = [string][char]7
        if ($env:TMUX) {
            $sequence = $esc + '`Ptmux;' + $esc + $esc + ']52;c;' + $encoded + $bel + $esc + '"'
        }
        else {
            $sequence = $esc + ']52;c;' + $encoded + $bel
        }

        [System.Console]::Out.Write($sequence)
        [System.Console]::Out.Flush()
    }
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

    ealias lg 'lazygit'
}

