local map = vim.api.nvim_set_keymap
local mapv2 = vim.keymap.set
local opt = { noremap = true, silent = true }
-- Disable Default Mappings
map("n", "s", "", opt)
map("n", "S", "", opt)
lvim.keys.normal_mode["<leader>f"] = false
lvim.keys.normal_mode["<leader>s"] = false
lvim.keys.normal_mode["<leader>c"] = false
-- Normal Mode
map("n", ";", ":", opt)
map("i", "jj", "<ESC>", opt)
-- 退出
-- map("n", "q", ":q<CR>", opt)
map("n", "qq", ":q!<CR>", opt)
-- insert 模式下，跳到行首行尾
map("i", "<C-h>", "<ESC>I", opt)
map("i", "<C-l>", "<ESC>A", opt)
-- normal 模式下，插入新的一行
map("n", "<leader>o", "o<ESC>", opt)
map("n", "<leader>O", "O<ESC>", opt)
-- 快速跳转
map("n", "<C-j>", "5j", opt)
map("n", "<C-k>", "5k", opt)
-- Save
mapv2({ "n", "i", "v" }, "<C-s>", "<cmd> w <CR>", opt)
-- 取消 s 默认功能
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
-- bufferline
-- 左右Tab切换
map("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
map("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)
-- visual模式下缩进代码
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)
-- leap
mapv2('n', '\\s', '<Plug>(leap)', opt)
mapv2('n', '\\S', '<Plug>(leap-from-window)', opt)
mapv2({ 'x', 'o' }, '\\s', '<Plug>(leap-forward)', opt)
mapv2({ 'x', 'o' }, '\\S', '<Plug>(leap-backward)', opt)
-- cmake
mapv2(
    { "v", "n", "i", "t" },
    "<F5>",
    "<cmd>wa<CR><cmd>if luaeval('require\"cmake-tools\".is_cmake_project()')|call execute('CMakeRun')|else|call execute('TermExec cmd=\\<C-c>')|endif<CR>",
    { silent = true }
)
-- X closes a buffer
lvim.keys.normal_mode["<leader>x"] = "<cmd>BufferKill<CR>"
-- Centers cursor when moving 1/2 page down
lvim.keys.normal_mode["<C-d>"] = "<C-d>zz"
-- Telescope
lvim.keys.normal_mode["<leader>fw"] = "<cmd>Telescope live_grep<CR>"
lvim.keys.normal_mode["<leader>fb"] = "<cmd>Telescope buffers<CR>"
lvim.keys.normal_mode["<leader>fh"] = "<cmd>Telescope help_tags<CR>"
lvim.keys.normal_mode["<leader>ma"] = "<cmd>Telescope marks<CR>"
lvim.keys.normal_mode["<leader>fo"] = "<cmd>Telescope oldfiles<CR>"
lvim.keys.normal_mode["<leader>fz"] = "<cmd>Telescope current_buffer_fuzzy_find<CR>"
lvim.keys.normal_mode["<leader>gt"] = "<cmd>Telescope git_status<CR>"
lvim.keys.normal_mode["<leader>pt"] = "<cmd>Telescope terms<CR>"
lvim.keys.normal_mode["<leader>th"] = "<cmd>Telescope themes<CR>"
lvim.keys.normal_mode["<leader>ff"] = "<cmd>Telescope find_files<cr>"
lvim.keys.normal_mode["<leader>fa"] = "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>"
lvim.keys.normal_mode["<leader>cm"] = "<cmd>Telescope cmake_tools sources initial_mode=insert<CR>"
lvim.keys.normal_mode["<leader>pr"] = "<cmd>Telescope projects<CR>"
lvim.keys.normal_mode["<leader>no"] = "<cmd>Telescope notify<CR>"
lvim.builtin.telescope.on_config_done = function(telescope)
    pcall(telescope.load_extension, "frecency")
    pcall(telescope.load_extension, "neoclip")
    pcall(telescope.load_extension, "aerial")
    -- any other extensions loading
end
-- Terminal
lvim.builtin.terminal.open_mapping = "<leader>t"
-- LSP
lvim.keys.normal_mode["<leader>ca"] = "<cmd>lua vim.lsp.buf.code_action({ apply = true })<CR>"
lvim.keys.normal_mode["<leader>fm"] = "<cmd>lua vim.lsp.buf.format { async = true }<CR>"
-- Session
lvim.builtin.which_key.mappings["S"] = {
    name = "Session",
    c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
    l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
    Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
}
lvim.builtin.which_key.mappings["a"] = {
    "<cmd>AerialToggle!<CR>", "Toggle Aerial",
}
lvim.builtin.telescope.defaults.mappings = {
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
