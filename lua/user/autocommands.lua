lvim.autocommands = {
    {
        "BufWinEnter", {
        pattern = { "CMakeLists.txt", "*.cmake" },
        callback = function()
            -- DYI editorconfig
            vim.cmd [[setlocal tabstop=2 shiftwidth=2]]
        end
    },
    }
}
