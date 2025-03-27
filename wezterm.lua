local wezterm = require 'wezterm'
return {
  color_scheme = 'Sakura',
  font = wezterm.font_with_fallback { 'Comic Code Ligatures', 'FantasqueSansM Nerd Font' },
  font_size = 14,
  window_close_confirmation = 'NeverPrompt',
  front_end = "WebGpu"
}
