require("mason").setup()
require("mason-lspconfig").setup({
	automatic_installation = true,
	ensure_installed = {
		"lua_ls",
		"rust_analyzer",
		"clangd",
		"cmake",
		"bashls",
	},
})

local g = vim.g
g.vsnip_snippet_dirs = {
	os.getenv("HOME") .. "/.local/share/nvim/lazy/friendly-snippets/snippets/",
}

function LspKeybind(client, bufnr)
	-- 禁用格式化功能，交给专门插件插件处理
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	-- 绑定快捷键
	require("keybindings").mapLSP(buf_set_keymap)
end

local nvim_lsp = require("lspconfig")
-- lua
-- mason.lua
nvim_lsp.lua_ls.setup({
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using
				-- (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {
					"vim",
					"require",
				},
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
	on_init = function(client)
		local path = client.workspace_folders[1].name
		if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
			client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = {
							"vim",
						},
					},
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
						},
					},
				},
			})

			client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
		end
		return true
	end,
	on_attach = LspKeybind,
})

-- rust_analyzer

nvim_lsp.rust_analyzer.setup({
	settings = {
		["rust-analyzer"] = {
			imports = {
				granularity = {
					group = "module",
				},
				prefix = "self",
			},
			cargo = {
				buildScripts = {
					enable = true,
				},
			},
			procMacro = {
				enable = true,
			},
		},
	},
	on_attach = LspKeybind,
})

nvim_lsp.tsserver.setup({
	on_attach = LspKeybind,
	filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
})

-- tailwindcss
nvim_lsp.tailwindcss.setup({})

nvim_lsp.pyright.setup({
	on_attach = LspKeybind,
})

nvim_lsp.marksman.setup({
	on_attach = LspKeybind,
})

nvim_lsp.clangd.setup({
	on_attach = LspKeybind,
	cmd = {
		"clangd",
		"--offset-encoding=utf-16",
		"-j=12",
		"--background-index",
		"--clang-tidy",
		"--pch-storage=memory",
		"--header-insertion=iwyu",
		"--completion-style=detailed",
		"--compile-commands-dir=build",
		"--pch-storage=disk",
		"--pch-storage=memory",
	},
})

nvim_lsp.cmake.setup({
	on_attach = LspKeybind,
	filetypes = { "cmake", "CMakeLists.txt" },
})

nvim_lsp.bashls.setup({
	on_attach = LspKeybind,
})

nvim_lsp.slint_lsp.setup({
	on_attach = LspKeybind,
})
