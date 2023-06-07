if ([System.Environment]::OSVersion.Platform -eq 'Unix') {
    Write-Host "This script is written for Windows.`nrun ./install.sh instead."
    exit
}

if ( !([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrators") ) {
    Start-Process -FilePath powershell.exe -ArgumentList "-executionpolicy bypass -File `"$($PSCommandPath)`"" -Verb RunAs
    exit
}

$jsonObject = Get-Content -Raw -Path "$PSScriptRoot\map.json" | ConvertFrom-Json


foreach ($item in $jsonObject) {

    $src = "$PSScriptRoot/$($item.src)"

    if ($item.dst -is [string]) {
        $dst = $item.dst
    } else {
        $dst = $item.dst.win
    }

    if ([string]::IsNullOrEmpty($dst)) {
        continue
    }

    Invoke-Expression "Write-Host ""New-Item -ItemType SymbolicLink -Path $dst -Target $src"""
    Invoke-Expression "New-Item -Force -ItemType SymbolicLink -Path $dst -Target $src" | Out-Null
}

git config --global include.path "$PSScriptRoot\\.gitconfig"
