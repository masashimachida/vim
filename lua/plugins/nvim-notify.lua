return
{
    "rcarriga/nvim-notify",
    config = function()
        require("notify").setup({
            top_down = false, -- 下から上に表示
            background_colour = vim.api.nvim_get_hl(0, { name = "Normal" }).bg or "#000000",
            timeout = 3000,   -- 3秒で自動消去
            stages = "static", -- 消え方のスタイル
        })
        -- 標準の vim.notify をこれに置き換える
        vim.notify = require("notify")
    end
}
