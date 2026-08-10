return
{
	"neovim/nvim-lspconfig", -- 依然として各LSPのデフォルト設定値として参照
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
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
			ensure_installed = { "ts_ls", "lua_ls", "phpactor", "cssls" },
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
		local servers = { "ts_ls", "lua_ls", "phpactor", "cssls" }

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
		}

		for _, server in ipairs(servers) do
			vim.lsp.config(server, vim.tbl_extend("force", {
				capabilities = capabilities,
			}, server_settings[server] or {}))
			vim.lsp.enable(server)
		end
	end,
}
