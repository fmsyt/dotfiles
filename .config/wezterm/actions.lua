local wezterm = require("wezterm")

local DEFAULT_OPACITY = 0.75
local OPACITY_STEP = 0.05

local function change_opacity(delta)
	return wezterm.action_callback(function(window, _)
		local overrides = window:get_config_overrides() or {}
		local opacity = overrides.window_background_opacity or DEFAULT_OPACITY
		overrides.window_background_opacity = math.max(0.0, math.min(1.0, opacity + delta))
		window:set_config_overrides(overrides)
	end)
end

return {
	increase_opacity = change_opacity(OPACITY_STEP),
	decrease_opacity = change_opacity(-OPACITY_STEP),
}
