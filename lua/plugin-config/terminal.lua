require("toggleterm").setup({
	float_opts = {
		border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        winblend = 8,
	},
	highlights = {
        Normal = {
            link = 'Normal'
        },
		FloatBorder = {
			link = "FloatBorder",
		},
        CursorLine = {
            link = 'Visual'
        },
	},
})
