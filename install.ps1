if ([System.Environment]::OSVersion.Platform -eq 'Unix') {
    Write-Host "This script is written for Windows.`nrun ./install.sh instead."
    exit
}

$processList = Get-Process powershell, pwsh 2>$null
$lastProcess = $processList | Sort-Object StartTime -Descending | Select-Object -First 1
Write-Host "Current process: $($lastProcess.ProcessName)"

if ( !([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrators") ) {
    Start-Process -FilePath $lastProcess.ProcessName -ArgumentList "-executionpolicy bypass -File `"$($PSCommandPath)`"" -Verb RunAs
    exit
}

function Expand-String {
    param (
        [string]$String
    )

    $expandedString = Invoke-Expression "Write-Output $String";
    return $expandedString
}


$jsonObject = Get-Content -Raw -Path "$PSScriptRoot\map.json" | ConvertFrom-Json


foreach ($item in $jsonObject) {

    $src = Expand-String -String "$PSScriptRoot\$($item.src)"
    Write-Host "Source: $src"

    if ($item.dst -is [string]) {
        $dst = Expand-String -String $item.dst
    }
    else {
        $dst = Expand-String -String $item.dst.win
    }

    if ([string]::IsNullOrEmpty($dst)) {
        continue
    }

    Write-Host "Destination: $dst"

    # exists and is symlink
    if ((Test-Path -Path $dst) -And ((Get-Item $dst).Attributes -band [System.IO.FileAttributes]::ReparsePoint)) {
        # nothing to do
    }
    elseif (Test-Path -Path $dst -PathType Leaf) {
        Write-Host "Create backup: $dst.bak"

        if (Test-Path -Path "$dst.bak") {
            Remove-Item -Path "$dst.bak" -Force -Recurse
            Write-Host "Old backup is deleted."
        }

        Copy-Item -Path "$dst" -Destination "$dst.bak"
        Remove-Item -Path "$dst" -Force
    }
    elseif (Test-Path -Path $dst -PathType Container) {
        Write-Host "Create backup: $dst.bak"

        if (Test-Path -Path "$dst.bak") {
            Remove-Item -Path "$dst.bak" -Force -Recurse
            Write-Host "Old backup is deleted."
        }

        Copy-Item -Path "$dst" -Destination "$dst.bak" -Recurse
        Remove-Item -Path "$dst" -Force -Recurse
    }

    Write-Host "New-Item -ItemType SymbolicLink -Path $dst -Target $src"
    New-Item -Force -ItemType SymbolicLink -Path $dst -Target $src | Out-Null

    Write-Host ""
}

git config --global include.path "$PSScriptRoot\\.gitconfig"

Pause
