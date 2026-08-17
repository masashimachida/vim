return
{
	"nvim-treesitter/nvim-treesitter",
	branch = "main", -- Neovim 0.12+向けの書き直し版（旧masterはアーカイブ済み）
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install({
			"html", "css", "javascript", "typescript", "tsx",
			"php", "lua", "sql", "json", "yaml", "markdown", "vim", "vimdoc",
		})

		-- ファイルタイプ検出時にハイライトとインデントを有効化
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "html", "css", "javascript", "typescript", "typescriptreact", "php", "lua", "sql", "json", "yaml", "markdown" },
			callback = function()
				vim.treesitter.start()
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
