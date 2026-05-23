return {
    "jwalton512/vim-blade",
    ft = { "blade" },
    init = function()
        vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
            pattern = "*.blade.php",
            callback = function()
                vim.bo.filetype = "blade"
            end,
        })
    end,
}
