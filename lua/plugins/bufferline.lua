return
{
	"akinsho/bufferline.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = {
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
	},
}
