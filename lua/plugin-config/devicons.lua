local status, devicons = pcall(require, "nvim-web-devicons")
if not status then
	vim.notify("没有找到 nvim-web-devicons")
	return
end

devicons.setup({
	default = true,
})
