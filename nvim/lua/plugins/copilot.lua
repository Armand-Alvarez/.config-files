return {
    {
        "github/copilot.vim", -- Main Copilot plugin
        config = function()
            -- Disable default Tab mapping
            --vim.g.copilot_no_tab_map = true

            -- Custom Copilot keybind (accept suggestion)
        -- 
            vim.keymap.set(
                "i",
                "<C-j>",
                'copilot#Accept("\\<CR>")',
                { expr = true, replace_keycodes = false, desc = "Accept Copilot suggestion" }
            )
        end,
    },

    {
        "CopilotC-Nvim/CopilotChat.nvim", -- Chat interface for Copilot
        dependencies = {
            "github/copilot.vim",           -- Depends on main Copilot plugin
            "nvim-lua/plenary.nvim",        -- Required for async utilities
        },
        opts = {
            -- Optional configuration
            window = {
                layout = "float",             -- "float", "split", or "vertical"
                width = 0.8,
                height = 0.8,
            },
            auto_insert_mode = true,
        },
        keys = {
            { "<leader>cc", "<cmd>CopilotChatToggle<CR>", desc = "Toggle Copilot Chat" },
        },
    },
}

