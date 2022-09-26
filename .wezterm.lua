// NOTE - PUBLIC CONFIG


local wezterm = require 'wezterm'

return {
  scrollback_lines = 5000,
  color_scheme = "Gruvbox Dark",
  font = wezterm.font 'JetBrains Mono',
  window_close_confirmation = "NeverPrompt",
}

