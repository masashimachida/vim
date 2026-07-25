return {
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        -- ここにお好みの設定を書きます（空でもデフォルトで動きます）
        signs = {
          add          = { text = '┃' },
          change       = { text = '┃' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        -- 便利なキーマップの設定例
        on_attach = function(bufnr)
          local gitsigns = require('gitsigns')

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Hunkの移動 (次の変更、前の変更へジャンプ)
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gitsigns.nav_hunk('next') end)
            return '<Ignore>'
          end, {expr=true, desc = "Next Git hunk"})

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gitsigns.nav_hunk('prev') end)
            return '<Ignore>'
          end, {expr=true, desc = "Previous Git hunk"})

          -- その場の変更差分をポップアップ表示 (Git diff)
          map('n', '<leader>hp', gitsigns.preview_hunk, { desc = "Preview Git hunk" })
        end
      })
    end
  }
}
