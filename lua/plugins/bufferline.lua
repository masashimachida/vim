return
{
	"akinsho/bufferline.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = function()
		-- テーマの警告色を流用して、未保存インジケーター(●)を目立たせる
		local warn_fg = vim.api.nvim_get_hl(0, { name = "DiagnosticWarn" }).fg
		-- 非アクティブなタブの文字色を、通常のコメント色よりさらに暗くする
		local comment_fg = string.format("#%06x", vim.api.nvim_get_hl(0, { name = "Comment" }).fg)
		local inactive_fg = require("bufferline.colors").shade_color(comment_fg, -35)
		-- アクティブなタブに背景色をつけて目立たせる
		-- (TabLineSelの色を少し落ち着かせて使用: 派手すぎず暗すぎない中間の明るさ)
		local tabsel_bg = string.format("#%06x", vim.api.nvim_get_hl(0, { name = "TabLineSel" }).bg)
		local active_bg = require("bufferline.colors").shade_color(tabsel_bg, -45)
		return {
			options = {
				mode = "buffers", -- タブに開いているバッファを表示
				-- IDE風にサイドバーの上のスペースを空ける設定
				offsets = {
					{
						filetype = "neo-tree",
						text = "File Explorer",
						text_align = "left",
						separator = true,
					},
				},
			},
			highlights = {
				modified = { fg = warn_fg, bold = true },
				modified_visible = { fg = warn_fg, bold = true },
				modified_selected = { fg = warn_fg, bold = true, bg = active_bg },
				buffer = { fg = inactive_fg },
				buffer_visible = { fg = inactive_fg },
				buffer_selected = { bg = active_bg, bold = true },
				duplicate_selected = { bg = active_bg },
				close_button_selected = { bg = active_bg },
				indicator_selected = { bg = active_bg },
				separator_selected = { bg = active_bg },
			},
		}
	end,
}
