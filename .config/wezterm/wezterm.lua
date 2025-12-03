local wezterm = require("wezterm")
local config = wezterm.config_builder()

local act = wezterm.action
local nf = wezterm.nerdfonts

config.initial_cols = 30 * 4
config.initial_rows = 8 * 4

config.default_cursor_style = "BlinkingUnderline"
config.use_ime = true
-- config.color_scheme = 'Monokai Soda (Gogh)'
-- config.color_scheme = 'Ef-Tritanopia-Dark'
-- config.color_scheme = 'duckbones'
-- config.color_scheme = 'Monokai (terminal.sexy)'
-- config.color_scheme = 'Nighty (Gogh)'
-- config.color_scheme = 'Purple People Eater (Gogh)'
config.color_scheme = "Railscasts (dark) (terminal.sexy)"

-- config.color_scheme = 'Red Planet'
-- config.color_scheme = 'Monokai Pro (Gogh)'
-- config.color_scheme = 'Monokai (dark) (terminal.sexy)'
-- config.color_scheme = 'Monokai Pro (Gogh)'
-- config.color_scheme = 'Monokai Pro Ristretto (Gogh)'

-- config.color_scheme = 'Kanagawa (Gogh)'
-- config.color_scheme = 'Kanagawa Dragon (Gogh)'
-- config.color_scheme = 'kanagawabones'

config.window_background_opacity = 0.75
config.tab_bar_at_bottom = true
config.tab_max_width = 24

config.line_height = 1.0

config.window_frame = {
	font_size = 10.0,
}

config.command_palette_font_size = 14.0
config.command_palette_rows = 8

local bg_active = "#1a1a1a"
local bg_inactive = "#333333"
local bg_hover = "#222222"

config.colors = {
	cursor_border = "#FFA500",
	tab_bar = {
		background = bg_active,
		active_tab = {
			-- The color of the background area for the tab
			bg_color = bg_active,
			-- The color of the text for the tab
			fg_color = "#c0c0c0",
			intensity = "Normal",
			underline = "None",
			italic = false,
			strikethrough = false,
		},
		inactive_tab = {
			bg_color = bg_inactive,
			fg_color = "#808080",
		},
		inactive_tab_hover = {
			bg_color = bg_hover,
			fg_color = "#909090",
			italic = true,
		},
		new_tab_hover = {
			bg_color = bg_hover,
			fg_color = "#909090",
			italic = true,
		},
	},
}

config.font = wezterm.font_with_fallback({
	-- { family = 'Moralerspace Krypton HWNF', weight = 'Medium' },
	{ family = "CaskaydiaCove Nerd Font" },
	{ family = "Cascadia Code" },
	{ family = "HackGen" },
	{ family = "Segoe UI Emoji", assume_emoji_presentation = true },
})

config.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = act.Nop,
	},
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = act.OpenLinkAtMouseCursor,
	},
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = wezterm.action_callback(function(window, pane)
			local has_selection = window:get_selection_text_for_pane(pane) ~= ""
			if has_selection then
				window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
				window:perform_action(act.ClearSelection, pane)
			else
				window:perform_action(act.PasteFrom("Clipboard"), pane)
			end
		end),
	},
}

function string:endswith(ending)
	return ending == "" or self:sub(-#ending) == ending
end

-- https://wezfurlong.org/wezterm/config/lua/window-events/format-tab-title.html
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = tab.active_pane.title

	if title:endswith("pwsh.exe") then
		title = "PowerShell"
	end

	if title:endswith("cmd.exe") then
		title = "cmd.exe"
	end

	title = tab.tab_index + 1 .. ": " .. title .. string.rep(" ", max_width)
	title = title:sub(1, max_width)
	return {
		{ Text = title },
	}
end)

local launch_menu = {}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_prog = { "pwsh.exe", "-NoLogo" }

	table.insert(launch_menu, {
		label = nf.cod_terminal_powershell .. " PowerShell7",
		args = { "pwsh.exe", "-NoLogo" },
	})

	table.insert(launch_menu, {
		label = nf.cod_terminal_linux .. " WSL",
		args = { "wsl.exe" },
	})

	-- Find installed visual studio version(s) and add their compilation
	-- environment command prompts to the menu
	for _, vsvers in ipairs(wezterm.glob("Microsoft Visual Studio/20*", "C:/Program Files")) do
		local year = vsvers:gsub("Microsoft Visual Studio/", "")
		table.insert(launch_menu, {
			label = nf.cod_terminal_cmd .. " Developper Command Prompt x64 Native Tools VS " .. year,
			args = {
				"cmd.exe",
				"/k",
				"C:/Program Files/" .. vsvers .. "/Community/Common7/Tools/VsDevCmd.bat",
				"-startdir=none",
				"-arch=x64",
				"-host_arch=x64",
			},
		})
	end
end

config.launch_menu = launch_menu

require("keybinds").apply(config)

if package.searchpath("local", package.path) then
	require("local").apply(config)
end

return config
