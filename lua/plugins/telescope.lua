return
{
	'nvim-telescope/telescope.nvim',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		require('telescope').setup({
			defaults = require('telescope.themes').get_ivy({
				-- 見た目の設定（中央に浮かせるスタイル）
				-- layout_strategy = 'horizontal',
				-- layout_config = {
					-- prompt_position = 'top',
				-- },
				-- 全ての検索に共通する Ivy の設定
				layout_config = {
					height = 0.3,
				},

				-- 境界線などをスッキリさせたい場合の設定
				-- border = true,

				sorting_strategy = 'ascending',

				-- 検索から除外するもの
				file_ignore_patterns = {
					"node_modules",
					".git/",
					".null-ls_*",
				},

				-- マッピング（Telescope内での操作）
				mappings = {
					i = {
						["<C-j>"] = "move_selection_next",
						["<C-k>"] = "move_selection_previous",
						["<C-q>"] = "send_to_qflist", -- Quickfixに送る
						["<esc>"] = require('telescope.actions').close, -- インサートモードから直接閉じる
						["<C-c>"] = require('telescope.actions').close, -- Ctrl + c でも閉じれるように（デフォルトでも入っていますが明示的）
					},
					n = {
						-- ノーマルモードでも esc で閉じる
						["<esc>"] = require('telescope.actions').close,
					},
				},
			}),
		})
	end
}
