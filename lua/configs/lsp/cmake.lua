require("cmake-tools").setup {
  cmake_command = "cmake", -- this is used to specify cmake command path
  cmake_regenerate_on_save = false, -- auto generate when save CMakeLists.txt
  cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" }, -- this will be passed when invoke `CMakeGenerate`
  cmake_build_options = {}, -- this will be passed when invoke `CMakeBuild`
  -- support macro expansion:
  --       ${kit}
  --       ${kitGenerator}
  --       ${variant:xx}
  -- cmake_build_directory = "out/${variant:buildType}", -- this is used to specify generate directory for cmake, allows macro expansion
  cmake_build_directory = "build", -- this is used to specify generate directory for cmake, allows macro expansion
  cmake_soft_link_compile_commands = false, -- this will automatically make a soft link from compile commands file to project root dir
  cmake_compile_commands_from_lsp = true, -- this will automatically set compile commands file location using lsp, to use it, please set `cmake_soft_link_compile_commands` to false
  cmake_kits_path = "ninja", -- this is used to specify global cmake kits path, see CMakeKits for detailed usage
  cmake_variants_message = {
    short = { show = true }, -- whether to show short message
    long = { show = true, max_length = 80 }, -- whether to show long message
  },
  cmake_dap_configuration = { -- debug settings for cmake
    name = "cpp",
    type = "codelldb",
    request = "launch",
    stopOnEntry = false,
    runInTerminal = true,
    console = "integratedTerminal",
  },
  cmake_executor = { -- executor to use
    name = "quickfix", -- name of the executor
    opts = {}, -- the options the executor will get, possible values depend on the executor type. See `default_opts` for possible values.
    default_opts = { -- a list of default and possible values for executors
      quickfix = {
        show = "always", -- "always", "only_on_error"
        position = "botright", -- "bottom", "top", "belowright"
        size = 10,
        encoding = "utf-8",
        auto_close_when_success = true, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
      },
      toggleterm = {
        direction = "horizontal", -- 'vertical' | 'horizontal' | 'tab' | 'float'
        close_on_exit = true, -- whether close the terminal when exit
        auto_scroll = true, -- whether auto scroll to the bottom
      },
      overseer = {},
      terminal = {
        name = "CMake Terminal",
        prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
        split_direction = "horizontal", -- "horizontal", "vertical"
        split_size = 6,

        -- Window handling
        single_terminal_per_instance = true, -- Single viewport, multiple windows
        single_terminal_per_tab = true, -- Single viewport per tab
        keep_terminal_static_location = true, -- Static location of the viewport if avialable

        -- Running Tasks
        start_insert = false, -- If you want to enter terminal with :startinsert upon using :CMakeRun
        focus = false, -- Focus on terminal when cmake task is launched.
        do_not_add_newline = true, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
      },
    },
  },
  cmake_runner = {
    -- name = "terminal",
    name = "toggleterm",
    opts = {},
    default_opts = { -- a list of default and possible values for runners
      quickfix = {
        show = "always", -- "always", "only_on_error"
        position = "belowright", -- "bottom", "top"
        size = 10,
        encoding = "utf-8",
        auto_close_when_success = true, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
      },
      toggleterm = {
        -- direction = "horizontal", -- 'vertical' | 'horizontal' | 'tab' | 'float'
        direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
        close_on_exit = false, -- whether close the terminal when exit
        auto_scroll = true, -- whether auto scroll to the bottom
        singleton = true, -- single instance, autocloses the opened one, if present
      },
      overseer = {},
      terminal = {
        name = "CMake Terminal",
        prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
        split_direction = "horizontal", -- "horizontal", "vertical"
        split_size = 6,

        -- Window handling
        single_terminal_per_instance = true, -- Single viewport, multiple windows
        single_terminal_per_tab = true, -- Single viewport per tab
        keep_terminal_static_location = true, -- Static location of the viewport if avialable

        -- Running Tasks
        start_insert = false, -- If you want to enter terminal with :startinsert upon using :CMakeRun
        focus = false, -- Focus on terminal when cmake task is launched.
        do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
      },
    },
  },
  cmake_notifications = {
    runner = { enabled = false },
    executor = { enabled = false },
    spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }, -- icons used for progress display
    refresh_rate_ms = 100, -- how often to iterate icons
  },
  cmake_virtual_text_support = false,
}

local function is_cmake_tools_running()
  local job = require("cmake-tools.utils").get_executor(
    require("cmake-tools.utils").executor.name
  ).job
  return not job or job.is_shutdown
end

local _terminal = require "cmake-tools.terminal"
local _quickfix = require "cmake-tools.quickfix"
-- local osys = require'cmake-tools.osys'
local notification = require "cmake-tools.notification"

local function shlex_quote(s)
  if s == "" then
    return [['']]
  end
  if s:find [["]] and s:find [[\]] then
    s = s:gsub([[\]], [[\\]])
    s = s:gsub([["]], [[\"]])
  end
  if s:find [["]] then
    return "'" .. s .. "'"
  end
  return '"' .. s .. '"'
end

-- !!cihou neogit:
-- vim.uv = vim.loop
-- function vim.system(cmd)
--     for i, c in ipairs(cmd) do
--         cmd[i] = shlex_quote(c)
--     end
--     cmd = table.concat(cmd, ' ')
--     local f = assert(io.popen(cmd, 'r'))
--     return {
--         wait = function(_)
--             local stdout = assert(f:read('*all'))
--             -- how to get the exit code?
--             local ok, code, signal = f:close()
--             return {
--                 code = ok and 0 or (code or signal),
--                 stdout = stdout,
--             }
--         end,
--     }
-- end

-- function _terminal.prepare_cmd_for_run(cmd, env, args, cwd)
--     local full_cmd = ""
--     -- executable = vim.fn.fnamemodify(executable, ":t")
--
--     -- if osys.islinux or osys.iswsl or osys.ismac then
--     --     full_cmd = 'clear && echo "--- $(date +%D\\ %T) ---" && '
--     -- end
--
--     -- Launch form executable's build directory by default
--     -- full_cmd = full_cmd .. 'cd ' .. shlex_quote(launch_path) .. ' &&'
--
--     if osys.iswin32 then
--         for _, v in ipairs(env) do
--             full_cmd = full_cmd .. " set " .. v .. " &&"
--         end
--     else
--         full_cmd = full_cmd .. table.concat(env, " ")
--     end
--
--     -- prepend wrap_call args
--     if wrap_call then
--         for _, arg in ipairs(wrap_call) do
--             full_cmd = full_cmd .. " " .. shlex_quote(arg)
--         end
--     end
--
--     -- full_cmd = full_cmd .. " "
--
--     if osys.islinux or osys.iswsl or osys.ismac then
--         full_cmd = " " .. full_cmd -- adding a space in front of the command prevents bash from recording the command in the history (if configured)
--     end
--
--     full_cmd = full_cmd .. shlex_quote(executable)
--
--     -- Add args to the cmd
--     if args then
--         for _, arg in ipairs(args) do
--             full_cmd = full_cmd .. shlex_quote(arg)
--         end
--     end
--
--     if osys.iswin32 then -- wrap in sub process to prevent env vars from being persited
--         full_cmd = 'cmd /C ' .. shlex_quote(full_cmd)
--     end
--
--     -- if osys.islinux or osys.iswsl or osys.ismac then
--     --     full_cmd = full_cmd .. ' && exit' -- exit if command succeeds (avoids terminal hanging)
--     -- end
--
--     local full_cmd = ""
--
--   -- Launch form executable's build directory by default
--   full_cmd = "cd " .. utils.transform_path(cwd) .. " &&"
--
--   if osys.iswin32 then
--     for k, v in pairs(env) do
--       full_cmd = full_cmd .. " set " .. k .. "=" .. v .. "&&"
--     end
--   else
--     for k, v in pairs(env) do
--       full_cmd = full_cmd .. " " .. k .. "=" .. v .. ""
--     end
--   end
--
--   full_cmd = full_cmd .. " " .. utils.transform_path(cmd)
--
--   if osys.islinux or osys.iswsl or osys.ismac then
--     full_cmd = " " .. full_cmd -- adding a space in front of the command prevents bash from recording the command in the history (if configured)
--   end
--
--   -- Add args to the cmd
--   for _, arg in ipairs(args) do
--     full_cmd = full_cmd .. " " .. arg
--   end
--
--   if osys.iswin32 then -- wrap in sub process to prevent env vars from being persited
--     full_cmd = 'cmd /C "' .. full_cmd .. '"'
--   end
--
--   return full_cmd
-- end

-- local function mock(cmd)
--      -- cmd can be 'cd /home/bate/Codes/co_async/build/ && /home/bate/Codes/co_async/build/proxy_route ; echo $? > /home/bate/.local/share/nvim/cmake-tools-tmp/exit_code && rm /home/bate/.local/share/nvim/cmake-tools-tmp/.lock'
--     -- we need to extract:
--     -- 1. the executable path: '/home/bate/Codes/co_async/build/proxy_route'
--     -- 2. the temp directory path: '/home/bate/.local/share/nvim/cmake-tools-tmp/'
--     -- let's use regex to do this:
--     local executable = cmd:match("&& ([^;]+) ;")
--     local temp_dir = cmd:match("echo %? > ([^;]+)")
--     vim.notify(vim.inspect({exec = executable, temp = temp_dir, cmd = cmd}))
--     -- write 0 to the temp_dir/exit_code and rm temp_dir/.lock:
--     vim.loop.fs_open(temp_dir .. "/exit_code", "w", 438, function(err, fd)
--         if err then
--             print("error opening file: " .. err)
--             return
--         end
--         vim.loop.fs_write(fd, "0", -1, function(err2)
--             if err2 then
--                 print("error writing to file: " .. err2)
--                 return
--             end
--             vim.loop.fs_close(fd, function(err3)
--                 if err3 then
--                     print("error closing file: " .. err3)
--                     return
--                 end
--                 vim.loop.fs_unlink(temp_dir .. "/.lock", function(err4)
--                     if err4 then
--                         print("error deleting file: " .. err4)
--                         return
--                     end
--                 end)
--             end)
--         end)
--     end)
--     cmd = ' ' .. executable
--     return cmd
-- end

-- function _terminal.send_data_to_terminal(buffer_idx, cmd, opts)
--     vim.notify('E' .. cmd)
--     -- if not opts or not opts.do_not_add_newline then
--     --     if osys.iswin32 then
--     --         cmd = cmd .. " \r"
--     --     elseif osys.ismac then
--     --         cmd = cmd .. " \n"
--     --     elseif osys.islinux then
--     --         cmd = cmd .. " \n"
--     --     elseif osys.iswsl then
--     --         --NOTE: Techinically, wsl-2 and linux are detected as linux. We might see a diferrence in wsl-1 vs wsl-2
--     --         cmd = cmd .. " \n"
--     --     end
--     -- else
--     --     -- Append a space but NOT the newline, so that the user has a chance to review the command before executing it
--     --     cmd = cmd .. " "
--     -- end
--
--     cmd = mock(cmd)
--
--     require'toggleterm'.exec(cmd)
--
--     -- if opts and opts.win_id ~= -1 then
--     --     -- The window is alive, so we set buffer in window
--     --     vim.api.nvim_win_set_buf(opts.win_id, buffer_idx)
--     --     if opts.split_direction == "horizontal" then
--     --         vim.api.nvim_win_set_height(opts.win_id, opts.split_size)
--     --     else
--     --         vim.api.nvim_win_set_width(opts.win_id, opts.split_size)
--     --     end
--     -- elseif opts and opts.win_id >= -1 then
--     --     -- The window is not active, we need to create a new buffer
--     --     vim.cmd(":" .. opts.split_direction .. " " .. opts.split_size .. "sp") -- Split
--     --     vim.api.nvim_win_set_buf(0, buffer_idx) -- Set buffer to newly created window
--     --     opts.win_id = vim.api.nvim_get_current_win()
--     -- else
--     --     vim.notify("Invalid window Id!", vim.log.levels.ERROR)
--     --     -- do nothing
--     -- end
--     --
--     -- -- Now, the cmake buffer's window is currently in focus
--     --
--     -- if opts and opts.focus then
--     --     -- We want to focus on the newly set terminal
--     --     vim.api.nvim_set_current_win(opts.win_id)
--     --     if opts.start_insert then
--     --         vim.cmd("startinsert")
--     --     end
--     --
--     --     -- Focus on the last line in the buffer to keep the scrolling output
--     --     -- [[ We keep this option enabled by default because when users scroll the buffer and run :CMakeCommands,
--     --     --    we must scroll the buffer even if they are focused on it
--     --     -- ]]
--     --     vim.api.nvim_buf_call(buffer_idx, function()
--     --         local type = vim.api.nvim_get_option_value("buftype", {
--     --             buf = buffer_idx,
--     --         })
--     --         if type == "terminal" then
--     --             vim.cmd("execute feedkeys('G', 't')")
--     --         end
--     --     end)
--     -- else
--     --
--     --     -- vim.api.nvim_set_current_win(opts.win_id)
--     --     -- Focus on the last line in the buffer to keep the scrolling output
--     --     -- [[ We keep this option enabled by default because when users scroll the buffer and run :CMakeCommands,
--     --     --    we must scroll the buffer even if they are focused on it
--     --     -- ]]
--     --     -- vim.api.nvim_buf_call(buffer_idx, function()
--     --     --     local type = vim.api.nvim_get_option_value("buftype", {
--     --     --         buf = buffer_idx,
--     --     --     })
--     --     --     if type == "terminal" then
--     --     --         vim.cmd("execute feedkeys('G', 't')")
--     --     --     end
--     --     -- end)
--     --
--     --     -- We want to focus on our currently focused window and not ther cmake terminal
--     --     local name = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(0))
--     --     local basename = vim.fn.fnamemodify(name, ":t")
--     --     if opts and (basename:sub(1, #opts.prefix) == opts.prefix) then -- If currently focused buffer is cmake buffer then ...
--     --         -- Now we check again if the buffer needs to be focused as the user might be scrolling
--     --         -- a cmake buffer and execute a :CMakeCommand, so we do not want to move their
--     --         -- cursor out of the cmake buffer, as it can be annoying
--     --         if opts and not opts.focus then
--     --             vim.cmd("wincmd p") -- Goes back to previous window: Equivalent to [[ CTRL-W p ]]
--     --         end
--     --     end
--     -- end
--     --
--     -- -- Finally send data to the terminal for execution
--     -- local chan = vim.api.nvim_buf_get_var(buffer_idx, "terminal_job_id")
--     -- vim.api.nvim_chan_send(chan, cmd)
-- end
--
-- function _terminal.new_instance(term_name, opts)
--   -- local buffers_before = vim.api.nvim_list_bufs()
--   --
--   -- -- Now create the plit
--   -- vim.cmd(":" .. opts.split_direction .. " " .. opts.split_size .. "sp | :term") -- Creater terminal in a split
--   -- -- local new_name = vim.fn.fnamemodify(term_name, ":t")                           -- Extract only the terminal name and reassign it
--   -- vim.api.nvim_buf_set_name(vim.api.nvim_get_current_buf(), term_name) -- Set the buffer name
--   -- vim.cmd(":setlocal laststatus=3") -- Let there be a single status/lualine in the neovim instance
--   --
--   -- -- Renamming a terminal buffer creates a new hidden buffer, so duplicate terminals need to be deleted
--   -- local new_buffers_list = vim.api.nvim_list_bufs()
--   -- local diff_buffers_list = _terminal.symmetric_difference(buffers_before, new_buffers_list)
--   -- _terminal.delete_duplicate_terminal_buffers_except(term_name, diff_buffers_list)
--   --
--   -- -- This is mainly for users to do filtering if necessary, as termial does not have a default type.
--   -- -- Example: using a filter in 'hardtime.nvim' to make sure
--   -- -- we can use chained hjkl keys in sucession in the terminal to scroll.
--   -- -- It also makes it easier to get the terminals that are unique to cmake_tools
--   -- vim.api.nvim_buf_set_option(vim.api.nvim_get_current_buf(), "filetype", "cmake_tools_terminal")
--   --
--   -- _terminal.delete_scratch_buffers()
--   --
--   -- local new_buffer_idx = _terminal.get_buffer_number_from_name(term_name)
--   -- return new_buffer_idx
--   return -1
-- end

-- function _quickfix.scroll_to_bottom()
--   vim.api.nvim_command("cbottom")
-- end
-- function _quickfix.scroll_to_bottom()
--     for _, win in ipairs(vim.api.nvim_list_wins()) do
--         if vim.bo[vim.api.nvim_win_get_buf(win)].buftype == 'quickfix' then
--             vim.cmd [[ cclose | Trouble qflist ]]
--             return
--         end
--     end
--     vim.cmd [[ Trouble qflist close ]]
-- end

local notification_blacklist = {
  ["Exited with code 0"] = true,
  ["cmake"] = true,
}
local old_notification_notify = notification.notify
function notification.notify(msg, lvl, opts)
  if msg ~= nil and not notification_blacklist[msg] then
    return old_notification_notify(msg, lvl, opts)
  end
end

function _quickfix.has_active_job(opts)
  if not _quickfix.job or _quickfix.job.is_shutdown then
    return false
  end
  local log = require "cmake-tools.log"
  log.info "Stop running CMake job..."
  _quickfix.stop()
  -- local log = require("cmake-tools.log")
  -- log.error(
  --   "A CMake task is already running: "
  --     .. _quickfix.job.command
  --     .. " Stop it before trying to run a new CMake task."
  -- )
  return true
end

local scratch = require "cmake-tools.scratch"
function scratch.append(cmd)
  vim.schedule(function()
    if scratch.buffer ~= nil then
      vim.api.nvim_buf_set_lines(scratch.buffer, -1, -1, false, { cmd })
    end
  end)
end

-- vim.cmd [[
-- " avoid terminal hanging
-- augroup auto_close_term
-- autocmd!
-- autocmd TermClose * execute 'bdelete! ' . expand('<abuf>')
-- augroup END
-- ]]
