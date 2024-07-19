local api = require "nvim-tree.api"
api.events.subscribe(api.events.Event.FileCreated, function(file)
  vim.cmd("edit " .. file.fname)
end)

vim.api.nvim_create_autocmd({ "BufEnter", "QuitPre" }, {
  nested = false,
  callback = function(e)
    local tree = api.tree

    -- Nothing to do if tree is not opened
    if not tree.is_visible() then
      return
    end

    -- How many focusable windows do we have? (excluding e.g. incline status window)
    local winCount = 0
    for _, winId in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_config(winId).focusable then
        winCount = winCount + 1
      end
    end

    -- We want to quit and only one window besides tree is left
    if e.event == "QuitPre" and winCount == 2 then
      vim.api.nvim_cmd({ cmd = "qall" }, {})
    end

    -- :bd was probably issued an only tree window is left
    -- Behave as if tree was closed (see `:h :bd`)
    if e.event == "BufEnter" and winCount == 1 then
      -- Required to avoid "Vim:E444: Cannot close last window"
      vim.defer_fn(function()
        -- close nvim-tree: will go to the last buffer used before closing
        tree.toggle { find_file = true, focus = true }
        -- re-open nivm-tree
        tree.toggle { find_file = true, focus = false }
      end, 10)
    end
  end,
})

api.events.subscribe(api.events.Event.FileCreated, function(file)
  vim.cmd("edit " .. file.fname)
end)

require("nvim-tree").setup {
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = false,
  },
  on_attach = require("mappings").mapNvimTree,
}
