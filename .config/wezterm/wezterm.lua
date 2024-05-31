local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Monokai Soda (Gogh)'
config.initial_cols = 120
config.initial_rows = 32
config.use_ime = true

config.font = wezterm.font_with_fallback {
    'CaskaydiaCove Nerd Font',
    'Cascadia Code',
}

config.keys = {{
    key = "\\",
    mods = "CTRL",
    action = wezterm.action_callback(function(window, pane)

        local info = pane:get_foreground_process_info()
        if info then
            -- wezterm.log_info(tostring(info.pid) .. ' ' .. info.executable)
        end


        window:perform_action(
            wezterm.action.SplitPane {
                direction = "Right",
                size = { Percent = 50 }
            },
            pane
        )

    end)
}}

local launch_menu = {}

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    config.default_prog = {'pwsh.exe'}

    table.insert(launch_menu, {
        label = 'pwsh',
        args = {'pwsh.exe', '-NoLogo'}
    })

    table.insert(launch_menu, {
        label = 'wsl',
        args = {'wsl.exe'}
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
