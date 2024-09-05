local wezterm = require 'wezterm'
local config = {}

config.color_scheme = "Catppuccin Mocha"
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0
}

config.font = wezterm.font 'JetBrains Mono'
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.80

return config
