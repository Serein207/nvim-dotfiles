require("mason").setup {
  automatic_installation = true,
  ensure_installed = {
    "rust_analyzer",
    "clangd",
    "cmake",
    "bashls",
    "clangd",
    "clang=format",
    "codelldb",
    "lua_ls",
    "stylua",
    "html",
    "cssls",
    "prettier",
    "marksman",
  },
}

local base = require "nvchad.configs.lspconfig"
local on_init = base.on_init
local capabilities = base.capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "cmake", "bashls", "marksman" }

function LspKeybind(client, bufnr)
  -- 禁用格式化功能，交给专门插件插件处理
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  -- 绑定快捷键
  require("mappings").mapLsp(buf_set_keymap)
end

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = LspKeybind,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- cpp
lspconfig.clangd.setup {
  on_attach = LspKeybind,
  capabilities = capabilities,
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
}

-- rust_analyzer
lspconfig.rust_analyzer.setup {
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
}
