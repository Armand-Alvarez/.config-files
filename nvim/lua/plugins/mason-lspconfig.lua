return {
	"williamboman/mason-lspconfig.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		require("mason").setup()

		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local on_attach = function(client, bufnr)
			if client.server_capabilities.documentFormattingProvider then
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = vim.api.nvim_create_augroup("LspFormat", { clear = true }),
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format()
					end,
				})
			end
		end

		require("mason-lspconfig").setup({
			ensure_installed = {
				"cssls",
				"eslint",
				"html",
				"jsonls",
				"pyright",
				"tailwindcss",
				"lua_ls",
			},
			automatic_installation = true,
			handlers = {
				-- Default handler for all servers
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
					})
				end,

				-- Override for Lua
				["lua_ls"] = function()
					require("lspconfig").lua_ls.setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = {
							Lua = {
								runtime = {
									version = "LuaJIT",
								},
								diagnostics = {
									globals = { "vim" },
								},
								workspace = {
									library = vim.api.nvim_get_runtime_file("", true),
									checkThirdParty = false,
								},
								telemetry = { enable = false },
							},
						},
					})
				end,
			},
		})
	end,
}
