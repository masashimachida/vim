return
{
	"neovim/nvim-lspconfig", -- 依然として各LSPのデフォルト設定値として参照
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/cmp-nvim-lsp",
        {
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			-- ensure_installed = { "ts_ls", "lua_ls", "intelephense", "phpactor" },
			ensure_installed = { "ts_ls", "lua_ls", "phpactor", "cssls", "sqls" },
		})
		require("mason-tool-installer").setup({
			-- LSPサーバー以外のツール（フォーマッタ・リンタ等）をmason経由で自動インストール
			ensure_installed = { "sql-formatter" },
		})

		vim.diagnostic.config({
			virtual_text = true,
			update_in_insert = false,
			severity_sort = true,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "󰅚",
					[vim.diagnostic.severity.WARN]  = "󱄊",
					[vim.diagnostic.severity.HINT]  = "󰌶",
					[vim.diagnostic.severity.INFO]  = "󱄑",
				}
			}
		})

		local capabilities = require('cmp_nvim_lsp').default_capabilities()
		-- local servers = { "ts_ls", "lua_ls", "intelephense", "phpactor" }
		local servers = { "ts_ls", "lua_ls", "phpactor", "cssls", "sqls" }

		-- サーバーごとの固有設定
		local server_settings = {
			cssls = {
				settings = {
					-- Marpテーマの @import-theme などカスタムat-ruleを未知として警告しない
					css = { lint = { unknownAtRules = "ignore" } },
					scss = { lint = { unknownAtRules = "ignore" } },
					less = { lint = { unknownAtRules = "ignore" } },
				},
			},
			intelephense = {
				settings = {
					intelephense = {
						completion = {
							fullyQualifyImportAnnotations = true,
							insertUseDeclaration = true,
						},
                        environment = {
                            language = "ja" -- メッセージを日本語に設定
                        },
                        stubs = {
                            "Core",
                            "standard",
                            -- 他に必要な stubs (例: "date", "json", "hash" など) があればここに記述
                        },
					},
				},
			},
			phpactor = {
				filetypes = { "php", "blade" },
				settings = {
					["phpactor.stub_resolver.source"] = "all", -- または "php" もしくは "all"
				},
			},
			sqls = {
				-- デフォルトの root_markers は直下の "config.yml" のみで
				-- .sqls/config.yml（サブディレクトリ配置）を検出できないため明示指定
				root_markers = { ".sqls", ".git" },
				-- プロジェクトルートに .sqls/config.yml があればそれを使う
				-- （なければ ~/.config/sqls/config.yml のグローバル設定にフォールバック）
				-- 注: on_new_config は lspconfig 独自フックで vim.lsp.config には効かないため
				-- cmd を関数形式にして root_dir 確定後に動的組み立てする
				cmd = function(dispatchers, config)
					local cmd = { "sqls" }
					local root_dir = config.root_dir
					if root_dir then
						local project_config = root_dir .. "/.sqls/config.yml"
						if vim.fn.filereadable(project_config) == 1 then
							cmd = { "sqls", "-config", project_config }
						end
					end
					return vim.lsp.rpc.start(cmd, dispatchers)
				end,
			},
		}

		for _, server in ipairs(servers) do
			vim.lsp.config(server, vim.tbl_extend("force", {
				capabilities = capabilities,
			}, server_settings[server] or {}))
			vim.lsp.enable(server)
		end
	end,
}
