return
{
	"nvimtools/none-ls.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local null_ls = require("null-ls")
		local u = require("null-ls.utils")
		-- none-lsのデフォルトroot検出は .git / Makefile / .null-ls-root のみで
		-- composer.json を見ないため、dp-app（Git管理外）の直下でnvimを開くと
		-- phpstan等がプロジェクトルート(app/)ではなくnvim起動時のcwdで実行され、
		-- vendorのautoloadを読めず「unknown class」の誤診断が発生する。
		-- composer.jsonのある場所を明示的にcwdとして解決する。
		local php_project_cwd = function(params)
			return u.root_pattern("composer.json")(params.bufname) or params.root
		end
		null_ls.setup({
			temp_dir = nil,
			sources = {
				-- phpcs: コード規約チェック
				null_ls.builtins.diagnostics.phpcs.with({
					extra_args = { "--stdin-path=$FILENAME" },
					cwd = php_project_cwd,
				}),
				-- null_ls.builtins.diagnostics.phpcs,
				-- phpstan: 静的解析（プロジェクトに phpstan.neon があるとより正確）
				null_ls.builtins.diagnostics.phpstan.with({
					cwd = php_project_cwd,
				}),
				-- phpcsfixer: フォーマッター
				null_ls.builtins.formatting.phpcsfixer.with({
					-- 標準入力から受け取り、ファイル名を指定して処理
					extra_args = { "--path-mode=intersection", "$FILENAME" },
					cwd = php_project_cwd,
				}),
				-- null_ls.builtins.formatting.phpcsfixer,
				-- sql-formatter: SQLフォーマッター
				null_ls.builtins.formatting.sql_formatter,
			},
		})
	end,
}
