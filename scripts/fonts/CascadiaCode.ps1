$response = Invoke-WebRequest -Uri "https://api.github.com/repos/microsoft/cascadia-code/releases/latest" -MaximumRedirection 5

$jsonObject = $response.Content | ConvertFrom-Json
Write-Host $jsonObject.tag_name

$tag = $jsonObject.tag_name -replace '^v', ''

$downloadUrl = "https://github.com/microsoft/cascadia-code/releases/download/v$tag/CascadiaCode-$tag.zip"
$fileName = "CascadiaCode-$tag.zip"

Write-Host "Downloading Cascadia Code version $tag from $downloadUrl"

$tmpDir = Join-Path $env:TEMP ([System.IO.Path]::GetRandomFileName())
New-Item -ItemType Directory -Path $tmpDir | Out-Null

Invoke-WebRequest -Uri "$downloadUrl" -OutFile "$tmpDir\$fileName"
# $fontsDir = "$HOME/.fonts/CascadiaCode"
#
# New-Item -ItemType Directory -Path $fontsDir -Force | Out-Null
# Add-Type -AssemblyName System.IO.Compression.FileSystem
# [System.IO.Compression.ZipFile]::ExtractToDirectory("$tmpDir\$fileName", $fontsDir)

explorer.exe $tmpDir

