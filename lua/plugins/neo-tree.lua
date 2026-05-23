return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- アイコン用
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	opts = {
		filesystem = {
			-- ファイルを開いた後もサイドバーを閉じない設定
			follow_current_file = {
				enabled = true,
			},
			use_libuv_file_watcher = true,
			filtered_items = {
				visible = true,          -- これをtrueにすると設定項目が有効になる
				show_hidden = true,      -- ドットファイルを表示する
				hide_dotfiles = false,   -- ドットファイルを隠さない
				hide_gitignored = false, -- .gitignore対象を隠さない（必要なら）
				hide_by_name = {
					".DS_Store",
					"thumbs.db",
				},
				never_show_by_pattern = {
					".null-ls_*",
				},
			},
		},
		git_status = {
			window = {
				mappings = {
					["a"]  = "git_add_file",                                      -- ここで a を git add に割り当てる
					["p"]  = { "toggle_preview", config = { use_float = true } }, -- プレビュー
					["d"]  = function(state)
						local node = state.tree:get_node()
						if node.type == "file" then
							vim.cmd("DiffviewOpen -- " .. node.path)
						end
					end,
					["gu"] = "git_unstage_file",
					["ga"] = "git_add_all",
					["gc"] = "git_commit",
					["gp"] = "git_push",
				}
			}
		},
		window = {
			width = 35,
            fixed_width = true,
			mappings = {
				-- サイドバー内で C-f を押しても「閉じない」ように上書き
				["<C-f>"] = "none",
				-- Ctrl + F で右側のエディタウィンドウにフォーカスを戻す
				["<C-F>"] = function()
					vim.api.nvim_command("wincmd l")
				end,
				-- ファイラ内のタブ切り替え
				["<Tab>"] = "next_source",
				["<S-Tab>"] = "prev_source",
			}
		},
		-- 使用するソースを指定
		sources = { "filesystem", "git_status" },

		source_selector = {
			winbar = true, -- 上部にタブを表示
			statusline = false,
			sources = {
				{ source = "filesystem", display_name = " 󰉓 Files" },
				{ source = "git_status", display_name = " 󰊢 Git" },
			},
		},
	},
}
