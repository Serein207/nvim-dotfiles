local M = {}

function M.init()
  M.config()
  M.window_style()
end

function M.config()
  vim.o.guifont = "Monaco Nerd Font Mono:h12"
  vim.g.neovide_no_idle = true
  vim.g.neovide_config_quit = true
  vim.g.neovide_fullscreen = false
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_cursor_vfx_mode = "railgun"
  vim.g.neovide_underline_stroke_scale = 1.0
end

function M.window_style()
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
end

if vim.g.neovide then
  M.init()
end
