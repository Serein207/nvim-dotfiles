local copilot = require("copilot")

copilot.setup({
	panel = {
		enabled = false,
    },
	suggestion = {
		enabled = true,
		auto_trigger = true,
		hide_during_completion = true,
		debounce = 75,
		keymap = {
			accept = "<A-CR>",
			accept_word = false,
			accept_line = "<C-CR>",
			next = "<A-]>",
			prev = "<A-[>",
			dismiss = "<C-]>",
		},
	},
	filetypes = {
		help = false,
		gitcommit = false,
		gitrebase = false,
		hgcommit = false,
		svn = false,
		cvs = false,
		["."] = false,
	},
	server_opts_overrides = {},
})
