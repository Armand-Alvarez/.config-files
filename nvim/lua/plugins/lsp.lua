return {
    "mason-org/mason-lspconfig.nvim",
    lazy = false,
    opts = {
        ensure_installed = { "pyright", "lua_ls" },  -- add lua_ls if you want it
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",  -- still needed for the config data
    },
    config = function()
        -- Setup the servers using the new API (Neovim 0.11+)
        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                },
            },
        })
        vim.lsp.enable("lua_ls")

        vim.lsp.config("pyright", {})
        vim.lsp.enable("pyright")
    end,
}
