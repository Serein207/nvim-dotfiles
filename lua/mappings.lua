local map = vim.api.nvim_set_keymap
local mapv2 = vim.keymap.set
local opt = { noremap = true, silent = true }

-- keymap sheet
map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })
-- to normal mode
map("n", ";", ":", opt)
map("i", "jj", "<ESC>", opt)
-- Ctrl+S 保存
mapv2({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", opt)
-- 取消 s 默认功能
map("n", "s", "", opt)
-- 分屏快捷键
map("n", "sv", "<C-w>v", opt)
map("n", "sh", "<C-w>s", opt)
-- 关闭当前laga
map("n", "sc", "<C-w>c", opt)
-- 关闭其他
map("n", "so", "<C-w>o", opt)
-- Alt + hjkl  窗口之间跳转
map("n", "<A-h>", "<C-w>h", opt)
map("n", "<A-j>", "<C-w>j", opt)
map("n", "<A-k>", "<C-w>k", opt)
map("n", "<A-l>", "<C-w>l", opt)
-- 左右比例控制
map("n", "<C-Left>", ":vertical resize -2<CR>", opt)
map("n", "<C-Right>", ":vertical resize +2<CR>", opt)
map("n", "s,", ":vertical resize -20<CR>", opt)
map("n", "s.", ":vertical resize +20<CR>", opt)
-- 上下比例
map("n", "sj", ":resize +10<CR>", opt)
map("n", "sk", ":resize -10<CR>", opt)
map("n", "<C-Down>", ":resize +2<CR>", opt)
map("n", "<C-Up>", ":resize -2<CR>", opt)
-- 等比例
map("n", "s=", "<C-w>=", opt)
-- outline
map("n", "<leader>a", "<cmd>AerialToggle!<CR>", opt)
-- Terminal相关
map("t", "<Esc>", "<C-\\><C-n>", opt)
mapv2("n", "<leader>t", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal new horizontal term" })
mapv2("n", "tv", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "terminal toggleable vertical term" })
mapv2("n", "th", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal new horizontal term" })
mapv2("n", "tf", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggle floating term" })

-- visual模式下缩进代码
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)
-- 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv", opt)
map("v", "K", ":move '<-2<CR>gv-gv", opt)
-- 快速移动
map("n", "<C-j>", "5j", opt)
map("n", "<C-k>", "5k", opt)

-- 在visual 模式里粘贴不要复制
map("v", "p", '"_dP', opt)

-- 退出
map("n", "q", ":q<CR>", opt)
map("n", "qq", ":q!<CR>", opt)

-- insert 模式下，跳到行首行尾
map("i", "<C-h>", "<ESC>I", opt)
map("i", "<C-l>", "<ESC>A", opt)
-- normal 模式下，插入新的一行
map("n", "<leader>o", "o<ESC>", opt)
map("n", "<leader>O", "O<ESC>", opt)

-- Comment
mapv2("n", "<leader>/", "gcc", { desc = "comment toggle", remap = true })
mapv2("v", "<leader>/", "gc", { desc = "comment toggle", remap = true })

--dap
map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", opt)
map("n", "<leader>dr", "<cmd> DapContinue <CR>", opt)
map("n", "<leader>bb", ":GoBreakToggle<CR>", opt)
map("n", "<leader>dd", ":GoDebug<CR>", opt)
map("n", "<leader>de", ":GoDebug -s<CR>", opt)

-- tabufline
-- 左右Tab切换
mapv2("n", "<C-l>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })
mapv2("n", "<C-h>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })
mapv2("n", "<leader>x", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })
mapv2("n", "<C-w>", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })

-- Telescope
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", opt)
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opt)
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opt)
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", opt)
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", opt)
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", opt)
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", opt)
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", opt)
map("n", "<leader>pt", "<cmd>Telescope terms<CR>", opt)
map("n", "<leader>th", "<cmd>Telescope themes<CR>", opt)
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opt)
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  opt
)
-- 查找文件（仅包含 CMake 目标所直接包含的源和头文件）
map("n", "<leader>cm", "<cmd>Telescope cmake_tools sources initial_mode=insert<CR>", opt)
-- project
map("n", "<leader>pr", ":Telescope projects<CR>", opt)
-- notify
map("n", "<leader>no", ":Telescope notify<CR>", opt)

-- nvim-tree
-- alt + m 键打开关闭tree
map("n", "<A-m>", ":NvimTreeToggle<CR>", opt)
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", opt)
-- leap
map("n", "<leader>s", "<Plug>(leap)", opt)
map("n", "S", "<Plug>(leap-backward)", opt)
map("n", "gs", "<Plug>(leap-from-window)", opt)

-- foramt
mapv2("n", "<leader>fm", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "format files" })

-- cmake_tools
mapv2(
  { "v", "n", "i", "t" },
  "<F5>",
  "<cmd>wa<CR><cmd>if luaeval('require\"cmake-tools\".is_cmake_project()')|call execute('CMakeRun')|else|call execute('TermExec cmd=\\<C-c>')|endif<CR>",
  { silent = true }
)
mapv2(
  { "v", "n", "i", "t" },
  "<F17>",
  "<cmd>wa<CR><cmd>if luaeval('require\"cmake-tools\".is_cmake_project()')|call execute('CMakeStopRunner')|call execute('CMakeStopExecutor')|else|call execute('TermExec cmd=\\<C-c>')|endif<CR>",
  { silent = true }
)

local pluginKeys = {}

-- Telescope 列表中 插入模式快捷键
pluginKeys.telescopeList = {
  i = {
    -- 上下移动
    ["<C-j>"] = "move_selection_next",
    ["<C-k>"] = "move_selection_previous",
    ["<Down>"] = "move_selection_next",
    ["<Up>"] = "move_selection_previous",
    -- 历史记录
    ["<C-n>"] = "cycle_history_next",
    ["<C-p>"] = "cycle_history_prev",
    -- 关闭窗口
    ["<C-c>"] = "close",
    -- 预览窗口上下滚动
    ["<C-u>"] = "preview_scrolling_up",
    ["<C-d>"] = "preview_scrolling_down",
  },
}

-- 列表快捷键
pluginKeys.mapNvimTree = function(bufnr)
  local api = require "nvim-tree.api"
  local mappings = {
    -- 打开文件或文件夹
    ["<CR>"] = { api.node.open.edit },
    ["<2-LeftMouse>"] = { api.node.open.edit },
    -- 分屏打开文件
    ["v"] = { api.node.open.vertical },
    -- 显示隐藏文件
    ["."] = { api.tree.toggle_hidden_filter },
    ["i"] = { api.tree.toggle_gitignore_filter },
    -- 文件操作
    ["<F5>"] = { api.tree.reload },
    -- git add
    ["ga"] = {
      function()
        require("utils").gitAdd()
      end,
    },
    ["a"] = { api.fs.create },
    ["c"] = { api.fs.copy.node, "Copy" },
    ["d"] = { api.fs.remove, "Delete" },
    ["p"] = { api.fs.paste, "Paste" },
    ["r"] = { api.fs.rename, "Rename" },
    ["x"] = { api.fs.cut, "Cut" },
    ["s"] = { api.node.run.system, "Run System" },
    ["S"] = { api.tree.search_node, "Search" },
    ["y"] = { api.fs.copy.filename, "Copy Name" },
    ["-"] = { api.tree.change_root_to_parent },
    ["+"] = { api.tree.change_root_to_node },
    ["<2-RightMouse>"] = { api.tree.change_root_to_node, "CD" },
  }
  for keys, mapping in pairs(mappings) do
    vim.keymap.set("n", keys, mapping[1], {
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true,
    })
  end
end

pluginKeys.mapLsp = function(mapbuf)
  -- rename
  mapbuf("n", "<leader>r", ":Lspsaga rename<CR>", opt)
  -- change source/header
  mapbuf("n", "<leader>ch", "<cmd>ClangdSwitchSourceHeader<CR>", opt)
  -- lsp
  mapbuf("n", "gd", "<cmd>vim.lsp.buf.type_definition()<CR>", opt)
  -- go xx
  mapbuf("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opt)
  mapbuf("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
  mapbuf("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opt)
  -- diagnostic
  mapbuf("n", "gp", "<cmd>Lspsaga show_line_diagnostics<CR>", opt)
  mapbuf("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opt)
  mapbuf("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opt)
end

pluginKeys.mapAerial = function(bufnr)
  mapv2("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
  mapv2("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
end

return pluginKeys
