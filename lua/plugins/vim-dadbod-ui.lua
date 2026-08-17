return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "psql" }, lazy = true }, -- Optional
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1

    -- クエリ結果が折りたたまれて表示されるのを防ぐ
    -- (dbout.vimがfoldmethod=exprを設定し、複数回クエリを実行すると
    --  2つ目以降の結果セットが折りたたまれたままになるため)
    -- foldenableはウィンドウローカルなため、dboutバッファを離れる際に
    -- 元に戻さないと、同じウィンドウで開いた別の通常ファイルにも
    -- foldenable=falseが引き継がれてしまう
    local dbout_augroup = vim.api.nvim_create_augroup("DbUiDboutFold", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = dbout_augroup,
      pattern = "dbout",
      callback = function()
        vim.opt_local.foldenable = false
      end,
    })
    vim.api.nvim_create_autocmd("BufWinLeave", {
      group = dbout_augroup,
      pattern = "*",
      callback = function(args)
        if vim.bo[args.buf].filetype == "dbout" then
          vim.wo.foldenable = true
        end
      end,
    })
  end,
}
