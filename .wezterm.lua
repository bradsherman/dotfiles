local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- config.color_scheme = "Kanagawa (Gogh)"
config.force_reverse_video_cursor = true
config.window_decorations = "NONE"
config.colors = {
	-- Kanagawa Wave
	foreground = "#dcd7ba",
	background = "#1f1f28",

	cursor_bg = "#c8c093",
	cursor_fg = "#c8c093",
	cursor_border = "#c8c093",

	selection_fg = "#c8c093",
	selection_bg = "#2d4f67",

	scrollbar_thumb = "#16161d",
	split = "#16161d",

	ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
	brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
	indexed = { [16] = "#ffa066", [17] = "#ff5d62" },

	-- Kanagawa Dragon
	-- foreground = "#c5c9c5",
	-- background = "#181616",
	--
	-- cursor_bg = "#c8c093",
	-- cursor_fg = "#c8c093",
	-- cursor_border = "#c8c093",
	--
	-- selection_fg = "#c8c093",
	-- selection_bg = "#2d4f67",
	--
	-- scrollbar_thumb = "#16161d",
	-- split = "#16161d",
	--
	-- ansi = { "#0d0c0c", "#c4746e", "#8a9a7b", "#c4b28a", "#8ba4b0", "#a292a3", "#8ea4a2", "#C8C093" },
	-- brights = { "#a6a69c", "#E46876", "#87a987", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#c5c9c5" },
	-- indexed = { [16] = "#b6927b", [17] = "#b98d7b" },
}
-- config.font = wezterm.font("IosevkaTerm Nerd Font Mono")
config.font = wezterm.font("Berkeley Mono")
-- config.font = wezterm.font("Victor Mono")
-- config.font = wezterm.font("Rec Mono Duotone")
config.term = "wezterm"
-- config.window_background_opacity = 0.9
-- config.text_background_opacity = 0.9
config.enable_tab_bar = false
-- config.default_prog = { "zellij", "-l", "welcome" }
config.window_padding = {
	left = "2cell",
	right = "2cell",
	top = "1cell",
	bottom = "1cell",
}
config.warn_about_missing_glyphs = false
config.keys = {
	{
		key = "Enter",
		mods = "ALT",
		action = wezterm.action.DisableDefaultAssignment,
	},

	--{ key = "Backspace", mods = "CTRL", action = wezterm.action.SendKey({ key = "w", mods = "CTRL" }) },
}
-- config.enable_kitty_keyboard = true
config.default_cursor_style = "SteadyBar"

return config
