return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",

	opts = {
		disable_filetype = { "TelescopePrompt", "vim" },
		map_cr = false,
	},

	config = function(_, opts)
		require("nvim-autopairs").setup(opts)
	end,
}
