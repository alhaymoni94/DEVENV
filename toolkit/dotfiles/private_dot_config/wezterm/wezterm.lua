-- wezterm.lua — Cross-platform WezTerm configuration
-- Matches Tokyo Night theme across tmux and micro

local wezterm = require 'wezterm'
local config  = wezterm.config_builder()
local act     = wezterm.action

-- ── OS detection ──────────────────────────────────────────────────────────────
local is_mac   = wezterm.target_triple:find("darwin")  ~= nil
local is_linux = wezterm.target_triple:find("linux")   ~= nil

-- ── Font ──────────────────────────────────────────────────────────────────────
config.font      = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Regular' })
config.font_size = 13.0
config.line_height = 1.1

-- ── Colors ────────────────────────────────────────────────────────────────────
config.color_scheme = 'Tokyo Night'

-- ── Window ────────────────────────────────────────────────────────────────────
config.window_padding        = { left = 8, right = 8, top = 8, bottom = 8 }
config.enable_tab_bar        = true
config.use_fancy_tab_bar     = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom     = false
config.window_decorations    = is_mac and "RESIZE" or "RESIZE"

-- ── Cursor ────────────────────────────────────────────────────────────────────
config.default_cursor_style  = 'BlinkingBar'
config.cursor_blink_rate     = 500

-- ── Shell ─────────────────────────────────────────────────────────────────────
local zsh_path = is_mac
  and '/opt/homebrew/bin/zsh'
  or  (os.getenv('SHELL') or '/usr/bin/zsh')
config.default_prog = { zsh_path }

-- ── Scrollback ────────────────────────────────────────────────────────────────
config.scrollback_lines = 10000

-- ── Key bindings ──────────────────────────────────────────────────────────────
-- Splitting and pane navigation is handled by tmux (Prefix+| and Prefix+-)
config.keys = {
  -- New tab
  { key = 't', mods = 'CTRL|SHIFT', action = act.SpawnTab 'CurrentPaneDomain' },
  -- Close tab
  { key = 'w', mods = 'CTRL|SHIFT', action = act.CloseCurrentTab { confirm = false } },
  -- Copy / paste
  { key = 'c', mods = 'CTRL|SHIFT', action = act.CopyTo 'Clipboard' },
  { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },
  -- Font size
  { key = '=', mods = 'CTRL',       action = act.IncreaseFontSize },
  { key = '-', mods = 'CTRL',       action = act.DecreaseFontSize },
  { key = '0', mods = 'CTRL',       action = act.ResetFontSize    },
}

return config
