return
{
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp", -- LSPからの補完
        "hrsh7th/cmp-buffer",   -- バッファ内の単語から補完
        "hrsh7th/cmp-path",     -- パスを補完
        "onsails/lspkind.nvim", -- 補完アイコン
    },
    config = function()
        local cmp = require("cmp")
        local lspkind = require("lspkind")
        cmp.setup({
            mapping = cmp.mapping.preset.insert({
                ['<Tab>'] = cmp.mapping.select_next_item(),
                ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'buffer' },
                { name = 'path' },
            }),
            formatting = {
                format = lspkind.cmp_format({ mode = "symbol_text" }),
            },
        })
    end,
}
