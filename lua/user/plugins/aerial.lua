require("aerial").setup({
    -- optionally use on_attach to set keymaps when aerial has attached to a buffer
    -- on_attach = function(bufnr)
    --     -- Jump forwards/backwards with '{' and '}'
    --     -- vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    --     -- vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
    -- end,
    nerd_font = "auto",
    use_icon_provider = true,
    dense = false,
    layout = {
        max_width = { 40, 0.25 },
        min_width = 16,
        resize_to_content = true,
        preserve_equality = true,
    },
    keymaps = {
        ["q"] = {
            callback = function() vim.cmd [[ :AerialClose ]] end,
            desc = "Close the aerial window",
            nowait = true,
        },
    },
})
