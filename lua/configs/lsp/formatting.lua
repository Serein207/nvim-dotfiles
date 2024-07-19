local conform = require "conform"
conform.setup {
  formatters_by_ft = {
    rust = { "rustfmt" },
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    markdown = { "prettier" },
    cpp = { "clang-format" },
  },
  default_format_opts = {
    lsp_format = "fallback",
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}
