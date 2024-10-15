local wezterm = require 'wezterm'
local config = wezterm.config_builder()

local act = wezterm.action

config.initial_cols = 120
config.initial_rows = 32
config.default_cursor_style = 'BlinkingUnderline'
config.use_ime = true
-- config.color_scheme = 'Monokai Soda (Gogh)'
-- config.color_scheme = 'Ef-Tritanopia-Dark'
-- config.color_scheme = 'duckbones'
-- config.color_scheme = 'Monokai (terminal.sexy)'
-- config.color_scheme = 'Nighty (Gogh)'
-- config.color_scheme = 'Purple People Eater (Gogh)'
config.color_scheme = 'Railscasts (dark) (terminal.sexy)'

-- config.color_scheme = 'Red Planet'
-- config.color_scheme = 'Monokai Pro (Gogh)'
-- config.color_scheme = 'Monokai (dark) (terminal.sexy)'
-- config.color_scheme = 'Monokai Pro (Gogh)'
-- config.color_scheme = 'Monokai Pro Ristretto (Gogh)'

-- config.color_scheme = 'Kanagawa (Gogh)'
-- config.color_scheme = 'Kanagawa Dragon (Gogh)'
-- config.color_scheme = 'kanagawabones'

config.window_background_opacity = 0.95
config.tab_bar_at_bottom = true
config.tab_max_width = 24

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    -- https://wezfurlong.org/wezterm/config/lua/config/win32_system_backdrop.html
    config.window_background_opacity = 0.5
    -- config.window_background_opacity = 0
    config.win32_system_backdrop = 'Acrylic'
    config.use_fancy_tab_bar = false
end

if wezterm.target_triple == 'x86_64-apple-darwin' then
    config.macos_window_background_blur = 20
end

config.window_frame = {
    font_size = 10.0
}

local bg_active = '#1a1a1a'
local bg_inactive = '#333333'
local bg_hover = '#222222'

config.colors = {
    cursor_border = '#FFA500',
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



config.font = wezterm.font_with_fallback {
    { family = 'CaskaydiaCove Nerd Font' },
    { family = 'Cascadia Code' },
    { family = 'HackGen' },
    { family = 'Segoe UI Emoji', assume_emoji_presentation = true },
}

config.mouse_bindings = {
    {
        event = { Up = { streak = 1, button = 'Left' } },
        mods = 'NONE',
        action = act.Nop,
    },
    {
        event = { Up = { streak = 1, button = 'Left' } },
        mods = 'CTRL',
        action = act.OpenLinkAtMouseCursor,
    },
    {
        event = { Down = { streak = 1, button = 'Right' } },
        mods = 'NONE',
        action = wezterm.action_callback(function(window, pane)
            local has_selection = window:get_selection_text_for_pane(pane) ~= ''
            if has_selection then
                window:perform_action(act.CopyTo 'ClipboardAndPrimarySelection', pane)
                window:perform_action(act.ClearSelection, pane)
            else
                window:perform_action(act.PasteFrom 'Clipboard', pane)
            end
        end)
    },
}

function string:endswith(ending)
    return ending == "" or self:sub(-#ending) == ending
end

local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

local function tab_title(tab_info)
    local title = tab_info.tab_title
    if title and #title > 0 then
        return title
    end

    title = tab_info.active_pane.title
    if title:endswith('pwsh.exe') then
        return 'PowerShell'
    end

    return title
end

-- https://wezfurlong.org/wezterm/config/lua/window-events/format-tab-title.html
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local edge_background = '#0b0022'
    local background = '#1b1032'
    local foreground = '#808080'

    if tab.is_active then
        background = '#2b2042'
        foreground = '#c0c0c0'
    elseif hover then
        background = '#3b3052'
        foreground = '#909090'
    end

    local edge_foreground = background

    local title = tab_title(tab)
    title = wezterm.truncate_right(title, max_width - 2)

    return {
        { Background = { Color = edge_background } },
        { Foreground = { Color = edge_foreground } },
        { Text = SOLID_LEFT_ARROW },
        { Background = { Color = background } },
        { Foreground = { Color = foreground } },
        { Text = title },
        { Background = { Color = edge_background } },
        { Foreground = { Color = edge_foreground } },
        { Text = SOLID_RIGHT_ARROW }
    }
end)

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
config.keys = require('keybinds').keys
config.key_tables = require('keybinds').key_tables

return config
