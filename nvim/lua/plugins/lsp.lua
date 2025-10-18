return {
    "mason-org/mason-lspconfig.nvim",
    lazy = false,
    opts = {
	ensure_installed = { "pyright" }
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
}
