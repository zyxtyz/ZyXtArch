local wezterm = require 'wezterm'
local json = wezterm.json

local config_dir = wezterm.config_dir
local f = io.open(config_dir .. "../pywal/colors.json", "r")
local colors = f and wezterm.serde.json_decode(f:read("*a"))
if f then f:close() end

local scheme = {}
if colors then
  scheme = {
    foreground = colors.colors.foreground,
    background = colors.colors.background,
    cursor_bg = colors.colors.color0,
    cursor_fg = colors.colors.foreground,
    selection_bg = colors.colors.color7,
    selection_fg = colors.colors.color0,
    ansi = {
      colors.colors.color0,
      colors.colors.color1,
      colors.colors.color2,
      colors.colors.color3,
      colors.colors.color4,
      colors.colors.color5,
      colors.colors.color6,
      colors.colors.color7,
    },
    brights = {
      colors.colors.color8,
      colors.colors.color9,
      colors.colors.color10,
      colors.colors.color11,
      colors.colors.color12,
      colors.colors.color13,
      colors.colors.color14,
      colors.colors.color15,
    }
  }
end

return {
  color_schemes = { ["wal"] = scheme },
  color_scheme = "wal",
  font_size = 14,
}
