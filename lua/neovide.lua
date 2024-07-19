local M = {}

function M.init()
	M.config()
	M.keybinding()
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

function M.keybinding()
	vim.keymap.set("n", "<C-S-s>", ":w<CR>") -- Save
	vim.keymap.set("v", "<C-S-c>", '"+y') -- Copy
	vim.keymap.set("n", "<C-S-v>", '"+P') -- Paste normal mode
	vim.keymap.set("v", "<C-S-v>", '"+P') -- Paste visual mode
	vim.keymap.set("c", "<C-S-v>", "<C-R>+") -- Paste command mode
	vim.keymap.set("i", "<C-S-v>", '<ESC>l"+Pli') -- Paste insert mode

	vim.api.nvim_set_keymap("", "<C-S-v>", "+p<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("!", "<C-S-v>", "<C-R>+", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("t", "<C-S-v>", "<C-R>+", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("v", "<C-S-v>", "<C-R>+", { noremap = true, silent = true })
end
function M.window_style()
	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0
end

if vim.g.neovide then
	M.init()
end
