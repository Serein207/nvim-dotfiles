-- 如果找不到lualine 组件，就不继续执行
local status, lualine = pcall(require, "lualine")
if not status then
	vim.notify("没有找到 lualine")
	return
end
local mode_groups = {
	["n"] = { "NORMAL", "Feline_NormalMode" },
	["no"] = { "N-PENDING", "Feline_NormalMode" },
	["i"] = { "INSERT", "Feline_InsertMode" },
	["ic"] = { "INSERT", "Feline_InsertMode" },
	["t"] = { "TERMINAL", "Feline_TerminalMode" },
	["v"] = { "VISUAL", "Feline_VisualMode" },
	["V"] = { "V-LINE", "Feline_VisualMode" },
	[""] = { "V-BLOCK", "Feline_VisualMode" },
	["R"] = { "REPLACE", "Feline_ReplaceMode" },
	["Rv"] = { "V-REPLACE", "Feline_ReplaceMode" },
	["s"] = { "SELECT", "Feline_SelectMode" },
	["S"] = { "S-LINE", "Feline_SelectMode" },
	[""] = { "S-BLOCK", "Feline_SelectMode" },
	["c"] = { "COMMAND", "Feline_CommandMode" },
	["cv"] = { "COMMAND", "Feline_CommandMode" },
	["ce"] = { "COMMAND", "Feline_CommandMode" },
	["r"] = { "PROMPT", "Feline_ConfirmMode" },
	["rm"] = { "MORE", "Feline_ConfirmMode" },
	["r?"] = { "CONFIRM", "Feline_ConfirmMode" },
	["!"] = { "SHELL", "Feline_TerminalMode" },
}
local config = {
	options = {
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = " ", right = "" },
	},
	extensions = { "nvim-tree", "toggleterm" },
	sections = {
		lualine_a = {
			{
				function()
					return " " .. mode_groups[vim.fn.mode()][1]
				end,
				-- "mode",
				-- icons_enabled = true,
			},
		},
		lualine_b = {
			{
				"filetype",
				colored = true,
				icon_only = true,
			},
			"filename",
		},
		lualine_c = {
			{
				"branch",
				icon = "",
				colored = true,
			},
			{
				"diff",
				symbols = { added = " ", modified = "󰝤 ", removed = " " },
			},
		},
		lualine_x = {
			"filesize",
		},

		lualine_y = { "encoding", "fileformat" },

		lualine_z = {
			"progress",
		},
	},
}

local colors = {
	yellow = "#ECBE7B",
	white = "#f0f0f0",
	darkblue = "#081633",
	green = "#98be65",
	orange = "#FF8800",
	violet = "#a9a1e1",
	magenta = "#c678dd",
	blue = "#51afef",
	red = "#ec5f67",
}

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end

ins_right({
	"lsp_progress",
	-- With spinner
	-- display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' }},
	colors = {
		percentage = colors.white,
		title = colors.white,
		message = colors.white,
		spinner = colors.white,
		lsp_client_name = colors.violet,
		use = true,
	},
	separators = {
		component = " ",
		progress = " | ",
		percentage = { pre = "", post = "%% " },
		title = { pre = "", post = ": " },
		lsp_client_name = { pre = "[", post = "]" },
		spinner = { pre = "", post = "" },
		message = { commenced = "In Progress", completed = "Completed" },
	},
	display_components = { pre = "(", post = ")", "lsp_client_name", "spinner", { "title", "percentage", "message" } },
	timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
	spinner_symbols = { "🌑 ", "🌒 ", "🌓 ", "🌔 ", "🌕 ", "🌖 ", "🌗 ", "🌘 " },
})

lualine.setup(config)
