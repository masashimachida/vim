return
{
	"nvimtools/none-ls.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			temp_dir = nil,
			sources = {
				-- phpcs: コード規約チェック
				null_ls.builtins.diagnostics.phpcs.with({
					extra_args = { "--stdin-path=$FILENAME" },
				}),
				-- null_ls.builtins.diagnostics.phpcs,
				-- phpstan: 静的解析（プロジェクトに phpstan.neon があるとより正確）
				null_ls.builtins.diagnostics.phpstan,
				-- phpcsfixer: フォーマッター
				null_ls.builtins.formatting.phpcsfixer.with({
					-- 標準入力から受け取り、ファイル名を指定して処理
					extra_args = { "--path-mode=intersection", "$FILENAME" },
				}),
				-- null_ls.builtins.formatting.phpcsfixer,
				-- sql-formatter: SQLフォーマッター
				null_ls.builtins.formatting.sql_formatter,
			},
		})
	end,
}
