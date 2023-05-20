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

    $src = Invoke-Expression "echo ""$PSScriptRoot/$($item.src)"""

    if ($item.dst -is [string]) {
        $dst = Invoke-Expression "echo ""$($item.dst)"""
    } else {
        $dst = Invoke-Expression "echo ""$($item.dst.win)"""
    }

    if ([string]::IsNullOrEmpty($dst)) {
        continue
    }

    Write-Host "New-Item -ItemType SymbolicLink -Path $dst -Target $src"
    New-Item -Force -ItemType SymbolicLink -Path $dst -Target $src | Out-Null
}

git config --global include.path "$PSScriptRoot/.gitconfig"
