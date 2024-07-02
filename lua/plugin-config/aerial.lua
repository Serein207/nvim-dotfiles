require("aerial").setup({
	backends = { "markdown", "man", "lsp", "treesitter" },
	layout = {
		max_width = { 30, 0.15 },
		placement = "edge",
		default_direction = "left",
	},
	attach_mode = "global",
})
