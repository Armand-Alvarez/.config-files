return {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
        {'nvim-telescope/telescope.nvim'},
        {'kkharji/sqlite.lua', module = 'sqlite'}, -- Include this for persistent history between sessions
    },
    opts = {
        history = 100,
        vim.keymap.set('n', '<Leader>p', function()
            vim.cmd('Telescope neoclip')
        end)
    }
}
