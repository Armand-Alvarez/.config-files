return {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = function(_, opts)
        -- 🔹 1. Remove Neovim’s default Tab keybinds (from vim/_defaults.lua)
        vim.schedule(function()
            pcall(vim.keymap.del, "i", "<Tab>")
            pcall(vim.keymap.del, "s", "<Tab>")
        end)

        -- 🔹 2. Override the default keymaps
        opts.keymap = {
            ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
            ['<C-e>'] = { 'hide', 'fallback' },
            ['<C-y>'] = { 'select_and_accept', 'fallback' },

            -- Smart Tab navigation
            ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
            ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },

            ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
            ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
        }

        -- 🔹 3. Keep your existing appearance, sources, fuzzy, etc.
        opts.appearance = {
            nerd_font_variant = 'mono',
        }

        opts.completion = {
            documentation = { auto_show = false },
        }

        opts.sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        }

        opts.fuzzy = { implementation = "prefer_rust_with_warning" }

        return opts
    end,

    opts_extend = { "sources.default" },
}
