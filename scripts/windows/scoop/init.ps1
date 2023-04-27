param(
    [string]$user = $null,
    [string]$global = $null
)


try {
    get-command scoop -ErrorAction Stop
}
catch [Exception] {

    if (![string]::IsNullOrEmpty($user)) {
        # インストールディレクトリの設定 (user)
        $env:SCOOP = $user
        [Environment]::SetEnvironmentVariable('SCOOP', $env:SCOOP, 'User')
    }

    if (![string]::IsNullOrEmpty($global)) {
        # インストールディレクトリの設定 (global)
        $env:SCOOP_GLOBAL = $global
        [Environment]::SetEnvironmentVariable('SCOOP_GLOBAL', $env:SCOOP_GLOBAL, 'Machine')
    }

    Set-ExecutionPolicy RemoteSigned -scope CurrentUser
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}

scoop install sudo

scoop bucket add main
scoop bucket add extras
scoop bucket add versions
scoop bucket add nerd-fonts
