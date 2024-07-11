local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- UI --
	-- - theme
	"navarasu/onedark.nvim",
	"folke/tokyonight.nvim",
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	"rcarriga/nvim-notify",
	"folke/noice.nvim",
	"nvim-lua/lsp-status.nvim",
	"petertriho/nvim-scrollbar",
	"norcalli/nvim-colorizer.lua",
	"lewis6991/hover.nvim",
	-- - smooth scroll
	"karb94/neoscroll.nvim",
	-- file tree
	{ "nvim-tree/nvim-web-devicons" },
	{ "kyazdani42/nvim-tree.lua", event = "VimEnter" },
	{ "akinsho/bufferline.nvim", dependencies = { "moll/vim-bbye" } },
	{ "nvim-lualine/lualine.nvim" },
	{ "arkav/lualine-lsp-progress" },
	"folke/which-key.nvim",
	"stevearc/aerial.nvim", -- 导航栏
	-- telescope
	{ "nvim-telescope/telescope.nvim" },
	"LinArcX/telescope-env.nvim",
	-- 自动补全
	{ "windwp/nvim-autopairs" },
	-- 快速移动
	"ggandor/leap.nvim", -- 快速移动
	"ggandor/flit.nvim", -- 利用 leap.nvim 强化 f/F t/T
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl" },
	-- dashboark
	{ "nvimdev/dashboard-nvim", event = "VimEnter", dependencies = { { "nvim-tree/nvim-web-devicons" } } },
	"ahmedkhalf/project.nvim",
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ "gelguy/wilder.nvim" },
	-- LSP
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	-- terminal
	{ "akinsho/toggleterm.nvim", version = "*", config = true },
	-- format
	{ "nvimtools/none-ls.nvim", dependencies = "nvim-lua/plenary.nvim" },
	-- 补全
    "zbirenbaum/copilot.lua",
	"hrsh7th/nvim-cmp",
    "hrsh7th/cmp-vsnip",
	"hrsh7th/vim-vsnip",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"mortepau/codicons.nvim",
	"lukas-reineke/cmp-under-comparator",
	"hrsh7th/cmp-nvim-lsp-signature-help",
	-- 常见片段
	"rafamadriz/friendly-snippets",
	-- UI增强
	"onsails/lspkind-nvim",
	{ "nvimdev/lspsaga.nvim", event = "BufEnter" },
	-- gitplugin
	"tpope/vim-fugitive", -- 显示 git blame，实现一些基本操作的快捷执行
	"rhysd/git-messenger.vim", -- 利用 git blame 显示当前行的 commit message
	"lewis6991/gitsigns.nvim",
	"f-person/git-blame.nvim", -- 显示 git blame 信息
	-- dap
	"mfussenegger/nvim-dap",
	"rcarriga/nvim-dap-ui",
	"theHamsta/nvim-dap-virtual-text",
    -- multi cursor
    "mg979/vim-visual-multi",
	-- cpp
	{
		"Civitasv/cmake-tools.nvim",
		init = function()
			local loaded = false
			local function check()
				local cwd = vim.uv.cwd()
				if vim.fn.filereadable(cwd .. "/CMakeLists.txt") == 1 then
					require("lazy").load({ plugins = { "cmake-tools.nvim" } })
					loaded = true
				end
			end
			check()
			vim.api.nvim_create_autocmd("DirChanged", {
				callback = function()
					if not loaded then
						check()
					end
				end,
			})
		end,
		lazy = true,
	},
	-- auto save
	"Pocco81/auto-save.nvim",
	-- markdown
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	-- comment
	{ "numToStr/Comment.nvim" },
	-- fcitx
	"h-hg/fcitx.nvim",
})
