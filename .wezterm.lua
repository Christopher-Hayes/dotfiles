// NOTE - PUBLIC CONFIG

local wezterm = require 'wezterm'

-- Workspace mgmt. Src: https://wezfurlong.org/wezterm/config/lua/keyassignment/SwitchWorkspaceRelative.html
wezterm.on("update-right-status", function(window, pane)
  window:set_right_status(window:active_workspace())
end)

return {
  adjust_window_size_when_changing_font_size = false,
  scrollback_lines = 5000,
  color_scheme = "Gruvbox Dark",
  font = wezterm.font 'JetBrains Mono',
  window_close_confirmation = "NeverPrompt",
  -- Fonts
  -- The default is the bundled JetBrains Mono, but it lacks the nerd glyphs required by nvim-tree.
  font = wezterm.font("FuraCode Nerd Font"),
  -- Keybindings
  keys = {
    -- MacOS word navigation
    -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
    {key="LeftArrow", mods="OPT", action=wezterm.action{SendString="\x1bb"}},
    -- Make Option-Right equivalent to Alt-f; forward-word
    {key="RightArrow", mods="OPT", action=wezterm.action{SendString="\x1bf"}},
  },

  quick_select = false,

  -- scrollback - increase history
  scrollback_lines = 15000,

  --title - prettify
  wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    return {
      {Text=" " .. tab.active_pane.title .. " "},
    }
  end),
}

