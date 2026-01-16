# 管理者権限の確認
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
  Write-Error "このスクリプトは管理者権限で実行する必要があります。"
  exit 1
}

Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*' | Where-Object State -eq 'NotPresent' | ForEach-Object {
  Add-WindowsCapability -Online -Name $_.Name
}

Get-Service -Name sshd | Set-Service -StartupType Automatic

# デフォルトシェルを変更
# cmd.exe < powershell.exe < pwsh.exe

$path = (Get-Command cmd.exe).Source

if (Get-Command pwsh.exe -ErrorAction SilentlyContinue) {
  $path = (Get-Command pwsh.exe).Source
} elseif (Get-Command powershell.exe -ErrorAction SilentlyContinue) {
  $path = (Get-Command powershell.exe).Source
}

Write-Host "Setting DefaultShell to $path"
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value $path -PropertyType String -Force
