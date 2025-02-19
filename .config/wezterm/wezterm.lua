local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local act = wezterm.action

config.color_scheme = "Catppuccin Mocha (Gogh)"
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0
}

config.initial_cols = 140
config.initial_rows = 36

config.window_frame = {
  border_left_width = '1px',
  border_right_width = '1px',
  border_bottom_height = '1px',
  border_top_height = '1px',
  border_left_color = '#2e2e2e',
  border_right_color = '#2e2e2e',
  border_bottom_color = '#2e2e2e',
  border_top_color = '#2e2e2e',
}
config.use_resize_increments = true

config.font_size = 10
config.font = wezterm.font 'JetBrains Mono'
config.window_background_opacity = 0.90
config.window_decorations = "RESIZE" -- use INTEGRATED_BUTTONS when linux fixes their shit
config.enable_scroll_bar = true
config.scrollback_lines = 10000
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.8
}

-- KEYMAP CONFIG

config.leader = { key = '\\', mods = 'CTRL', timeout_milliseconds = 1000 }

config.keys = {
  -- send C-a on double C-a
  {
    key = '\\',
    mods = 'LEADER|CTRL',
    action = act.SendKey { key = '\\', mods = 'CTRL' }
  },

  { key = 'h', mods = 'LEADER',     action = act.SplitVertical },
  { key = 'v', mods = 'LEADER',     action = act.SplitHorizontal },
  { key = 'q', mods = 'LEADER',     action = act.CloseCurrentPane { confirm = true } },

  -- increase/decrease font size only with leader and  CTRL + + and CTRL + -
  { key = '+', mods = 'SHIFT|CTRL', action = act.DisableDefaultAssignment },
  { key = '_', mods = 'SHIFT|CTRL', action = act.DisableDefaultAssignment },

  -- C+S+PageUp/Down go to next/prev prompt
  { key = 'PageUp',    mods = 'SHIFT|CTRL', action = act.ScrollToPrompt(-1) },
  { key = 'PageDown',  mods = 'SHIFT|CTRL', action = act.ScrollToPrompt(1) },
}

return config
