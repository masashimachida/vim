return {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    keymaps = {
        view = {
            -- 差分表示中に q で閉じる
            { "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close Diffview" } },
        },
        file_panel = {
            -- ファイル一覧パネルでも q で閉じる
            { "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close Diffview" } },
        },
    },
}
