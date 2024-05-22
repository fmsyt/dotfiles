local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Monokai Soda (Gogh)'
config.font = wezterm.font_with_fallback {'Moralerspace Krypton HWNF', 'CaskaydiaCove Nerd Font', 'Cascadia Code'}
config.initial_cols = 120
config.initial_rows = 32


local launch_menu = {}

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    config.default_prog = {'pwsh.exe'}

    table.insert(launch_menu, {
        label = 'pwsh',
        args = {'pwsh.exe', '-NoLogo'}
    })

    table.insert(launch_menu, {
        label = 'PowerShell',
        args = {'powershell.exe', '-NoLogo'}
    })

    -- Find installed visual studio version(s) and add their compilation
    -- environment command prompts to the menu
    for _, vsvers in ipairs(wezterm.glob('Microsoft Visual Studio/20*', 'C:/Program Files (x86)')) do
        local year = vsvers:gsub('Microsoft Visual Studio/', '')
        table.insert(launch_menu, {
            label = 'x64 Native Tools VS ' .. year,
            args = {'cmd.exe', '/k',
                    'C:/Program Files (x86)/' .. vsvers .. '/BuildTools/VC/Auxiliary/Build/vcvars64.bat'}
        })
    end
end

config.launch_menu = launch_menu

return config
