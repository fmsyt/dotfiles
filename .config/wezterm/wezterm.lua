local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.initial_cols = 120
config.initial_rows = 32
config.use_ime = true
config.color_scheme = 'Monokai Soda (Gogh)'

config.window_frame = {
    font_size = 10.0
}

local bg_active = '#1a1a1a'
local bg_inactive = '#333333'
local bg_hover = '#222222'

config.colors = {
    tab_bar = {
        background = bg_active,
        active_tab = {
            -- The color of the background area for the tab
            bg_color = bg_active,
            -- The color of the text for the tab
            fg_color = '#c0c0c0',
            intensity = 'Normal',
            underline = 'None',
            italic = false,
            strikethrough = false
        },
        inactive_tab = {
            bg_color = bg_inactive,
            fg_color = '#808080'
        },
        inactive_tab_hover = {
            bg_color = bg_hover,
            fg_color = '#909090',
            italic = true
        },
        new_tab = {
            bg_color = bg_inactive,
            fg_color = '#808080'
        },
        new_tab_hover = {
            bg_color = bg_hover,
            fg_color = '#909090',
            italic = true
        }
    }
}

config.font = wezterm.font_with_fallback {'CaskaydiaCove Nerd Font', 'Cascadia Code'}

-- config.keys = {{
--     key = "\\",
--     mods = "CTRL",
--     action = wezterm.action_callback(function(window, pane)

--         local info = pane:get_foreground_process_info()
--         if info then
--             -- wezterm.log_info(tostring(info.pid) .. ' ' .. info.executable)
--         end

--         window:perform_action(
--             wezterm.action.SplitPane {
--                 direction = "Right",
--                 size = { Percent = 50 }
--             },
--             pane
--         )

--     end)
-- }}

config.mouse_bindings = {{
    event = {
        Down = {
            streak = 1,
            button = 'Right'
        }
    },
    mods = 'NONE',
    action = wezterm.action.PasteFrom 'Clipboard'
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
