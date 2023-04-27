if ([System.Environment]::OSVersion.Platform -eq 'Unix') {
    Write-Host "This script is written for Windows.`nrun ./install.sh instead."
    exit
}

$jsonSchema = Get-Content -Raw -Path "$PSScriptRoot\map.schema.json" | ConvertFrom-Json
$jsonObject = Get-Content -Raw -Path "$PSScriptRoot\map.json" | ConvertFrom-Json


foreach ($item in $jsonObject) {

    $src = Invoke-Expression "echo ""$PSScriptRoot/$($item.src)"""

    Write-Host "src: $src"

    if ($item.dst -is [string]) {
        $dst = Invoke-Expression "echo ""$($item.dst)"""
    } else {
        $dst = Invoke-Expression "echo ""$($item.dst.win)"""
    }

    if ([string]::IsNullOrEmpty($dst)) {
        $dst = $src
    }

    Write-Host "dst: $dst"

    New-Item -ItemType SymbolicLink -Path $dst -Target $src
}
