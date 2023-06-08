if ([System.Environment]::OSVersion.Platform -eq 'Unix') {
    Write-Host "This script is written for Windows.`nrun ./install.sh instead."
    exit
}

if ( !([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrators") ) {
    Start-Process -FilePath powershell.exe -ArgumentList "-executionpolicy bypass -File `"$($PSCommandPath)`"" -Verb RunAs
    exit
}

function Expand-String {
    param (
        [string]$String
    )

    $expandedString = Invoke-Command -ScriptBlock { $ExecutionContext.InvokeCommand.ExpandString($Using:String) }
    return $expandedString
}


$jsonObject = Get-Content -Raw -Path "$PSScriptRoot\map.json" | ConvertFrom-Json


foreach ($item in $jsonObject) {

    $src = Expand-String -String "$PSScriptRoot/$($item.src)"

    if ($item.dst -is [string]) {
        $dst = $item.dst
    } else {
        $dst = $item.dst.win
    }

    if ([string]::IsNullOrEmpty($dst)) {
        continue
    }

    # exists and is symlink
    if (!(Test-Path -Path $dst) -And ((Get-Item $dst).Attributes -band [System.IO.FileAttributes]::ReparsePoint)) {
        # nothing to do
    }
    elseif (Test-Path -Path $dst -PathType Leaf) {
        Copy-Item -Path "$dst" -Destination """$dst.bak"""
    }
    elseif (Test-Path -Path $dst -PathType Container) {
        Copy-Item -Path "$dst" -Destination """$dst.bak""" -Recurse
    }

    Invoke-Expression "Write-Host ""New-Item -ItemType SymbolicLink -Path $dst -Target $src"""
    Invoke-Expression "New-Item -Force -ItemType SymbolicLink -Path $dst -Target $src" | Out-Null
}

git config --global include.path "$PSScriptRoot\\.gitconfig"
