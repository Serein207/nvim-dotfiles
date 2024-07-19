return {
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  "stevearc/conform.nvim",
  "gelguy/wilder.nvim",
  "ggandor/leap.nvim", -- 快速移动
  "folke/noice.nvim",
  "rcarriga/nvim-notify",
  "tpope/vim-fugitive", -- 显示 git blame，实现一些基本操作的快捷执行
  "rhysd/git-messenger.vim", -- 利用 git blame 显示当前行的 commit message
  "lewis6991/gitsigns.nvim",
  "mfussenegger/nvim-dap",
  "stevearc/aerial.nvim", -- 导航栏
  "nvim-lua/plenary.nvim",
  "mg979/vim-visual-multi",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "mortepau/codicons.nvim",
  "ahmedkhalf/project.nvim",
  "lewis6991/hover.nvim",
  "zbirenbaum/copilot.lua",
  { "akinsho/toggleterm.nvim", version = "*", config = true },
  {
    "Civitasv/cmake-tools.nvim",
    dependencies = { "stevearc/overseer.nvim" },
    lazy = true,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {},
      ensure_installed = {
        "codelldb",
      },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.optn()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
}
