local status, project = pcall(require, "project_nvim")
if not status then
	vim.notify("没有找到 project_nvim")
	return
end

-- nvim-tree 支持
vim.g.nvim_tree_respect_buf_cwd = 1

project.setup({
	detection_methods = { "pattern" },
	patterns = { ".git", "_darcs", "Makefile", "package.json", ".sln", ".clang-format", "cargo.toml", "Hyprland.conf" },
})

local status, telescope = pcall(require, "telescope")
if not status then
	vim.notify("没有找到 telescope")
	return
end
pcall(telescope.load_extension, "projects")
