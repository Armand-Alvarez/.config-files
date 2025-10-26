return {
    "github/copilot.vim",
    -- Load this before config so the variable is set early
    init = function()
        vim.g.copilot_no_tab_map = true
    end,
    config = function()
        -- Optional: map <C-J> for Copilot accept
        vim.keymap.set('i', '<C-J>', 'copilot#Accept("<CR>")', {
            expr = true,
            replace_keycodes = false
        })
    end,
}
