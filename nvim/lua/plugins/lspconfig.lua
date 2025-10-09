return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },

	config = function()
		local lspconfig = require("lspconfig")
		local util = require("lspconfig.util")

		-- Automatically get Poetry Python interpreter
		local function get_poetry_python()
			local handle = io.popen("poetry env info -p 2>/dev/null")
			if handle then
				local result = handle:read("*a")
				handle:close()
				local path = result:gsub("%s+", "")
				if path ~= "" then
					return path .. "/bin/python"
				end
			end
			return vim.fn.exepath("python3")
		end

		-- Setup Pyright using the new style but still within lspconfig
		lspconfig.pyright.setup({
			root_dir = util.root_pattern("pyproject.toml", ".git"),
			settings = {
				python = {
					pythonPath = get_poetry_python(),
				},
			},
		})
	end,
}
