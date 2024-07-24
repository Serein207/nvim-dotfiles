vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"
require "neovide"
require "mappings"
require "configs.dap.cpp"
require "configs.lsp.setup"
require "configs.lsp.cmp"
require "configs.lsp.formatting"
require "configs.lsp.clangd"
require "configs.lsp.hover"
require "configs.lsp.cmake"
require "configs.nvim-treesitter"
require "configs.nvim-tree"
require "configs.leap"
require "configs.notify"
require "configs.noice"
require "configs.aerial"
require "configs.telescope"
require "configs.gitsigns"
require "configs.wilder"
require "configs.copilot"
require "configs.project"
