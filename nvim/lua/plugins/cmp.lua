return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lsp",
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
		"onsails/lspkind.nvim",
	},

	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        local handlers = require('nvim-autopairs.completion.handlers')

        cmp.event:on(
          'confirm_done',
          cmp_autopairs.on_confirm_done({
            filetypes = {
              -- "*" is a alias to all filetypes
              ["*"] = {
                ["("] = {
                  kind = {
                    cmp.lsp.CompletionItemKind.Function,
                    cmp.lsp.CompletionItemKind.Method,
                  },
                  handler = handlers["*"]
                }
              },
              lua = {
                ["("] = {
                  kind = {
                    cmp.lsp.CompletionItemKind.Function,
                    cmp.lsp.CompletionItemKind.Method
                  },
                  ---@param char string
                  ---@param item table item completion
                  ---@param bufnr number buffer number
                  ---@param rules table
                  ---@param commit_character table<string>
                  handler = function(char, item, bufnr, rules, commit_character)
                    -- Your handler function. Inspect with print(vim.inspect{char, item, bufnr, rules, commit_character})
                  end
                }
              },
              -- Disable for tex
              tex = false
            }
          })
        )

		require("luasnip.loaders.from_vscode").lazy_load()


		-- Optional: recommended completion behavior
		vim.o.completeopt = "menuone,noinsert,noselect"
		vim.cmd([[highlight! default link CmpItemKind CmpItemMenuDefault]])
	end,
}
