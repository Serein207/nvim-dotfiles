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
local on_attach = base.on_attach
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
  return on_attach(client, bufnr)
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
  on_attach = function(client, bufnr)
    LspKeybind(client, bufnr)
    require("clangd_extensions.inlay_hints").setup_autocmd()
    require("clangd_extensions.inlay_hints").set_inlay_hints()
    local group =
      vim.api.nvim_create_augroup("clangd_no_inlay_hints_in_insert", { clear = true })

    vim.keymap.set("n", "<leader>lh", function()
      if require("clangd_extensions.inlay_hints").toggle_inlay_hints() then
        vim.api.nvim_create_autocmd("InsertEnter", {
          group = group,
          buffer = bufnr,
          callback = require("clangd_extensions.inlay_hints").disable_inlay_hints,
        })
        vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
          group = group,
          buffer = bufnr,
          callback = require("clangd_extensions.inlay_hints").set_inlay_hints,
        })
      else
        vim.api.nvim_clear_autocmds { group = group, buffer = bufnr }
      end
    end, { buffer = bufnr, desc = "[l]sp [h]ints toggle" })
  end,
  root_dir = function(fname)
    return require("lspconfig.util").root_pattern(
      "Makefile",
      "configure.ac",
      "configure.in",
      "config.h.in",
      "meson.build",
      "meson_options.txt",
      "build.ninja"
    )(fname) or require("lspconfig.util").root_pattern(
      "compile_commands.json",
      "compile_flags.txt"
    )(fname) or require("lspconfig.util").find_git_ancestor(fname)
  end,
  capabilities = {
    offsetEncoding = { "utf-16" },
  },
  cmd = {
    "clangd",
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
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    clangdFileStatus = true,
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
