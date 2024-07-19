local dap = require "dap"

dap.adapters.codelldb = {
  type = "server",
  host = "127.0.0.1",
  port = 13000, -- 💀 Use the port printed out or specified with `--port`
  executable = {
    -- CHANGE THIS to your path!
    command = "codelldb",
    args = { "--port", "${port}" },
    -- On windows you may have to uncomment this:
    -- detached = false,
  },
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}
