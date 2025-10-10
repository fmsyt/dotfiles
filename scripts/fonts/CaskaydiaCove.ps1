$response = Invoke-WebRequest -Uri "https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest" -MaximumRedirection 5

$jsonObject = $response.Content | ConvertFrom-Json
$tag = $jsonObject.tag_name -replace '^v', ''

$downloadUrl = "https://github.com/ryanoasis/nerd-fonts/releases/download/v$tag/CascadiaCode.zip"
$fileName = "CaskaydiaCove-$tag.zip"

$shellapp = New-Object -ComObject Shell.Application
$downloadDir = $shellapp.Namespace("shell:Downloads").Self.Path

if (Test-Path "$downloadDir\$fileName") {
    Write-Host "File $fileName already exists in $downloadDir"
    Invoke-Item "$downloadDir"
    exit
}

Write-Host "Downloading CaskaydiaCove version $tag from $downloadUrl"
Invoke-WebRequest -Uri "$downloadUrl" -OutFile "$downloadDir\$fileName"

Write-Host "Downloads to $downloadDir\$fileName"

Invoke-Item "$downloadDir"
