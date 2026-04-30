return
{
	"neovim/nvim-lspconfig", -- 依然として各LSPのデフォルト設定値として参照
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = { "ts_ls", "lua_ls", "intelephense", "phpactor" },
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
		local servers = { "ts_ls", "lua_ls", "intelephense", "phpactor" }

		-- サーバーごとの固有設定
		local server_settings = {
			intelephense = {
				settings = {
					intelephense = {
						completion = {
							fullyQualifyImportAnnotations = true,
							insertUseDeclaration = true,
						},
					},
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
