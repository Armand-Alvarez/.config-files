return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    opts = {},
    config = function(_, opts)
        local harpoon = require("harpoon")
        harpoon:setup(opts)

        local conf = require("telescope.config").values

        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            require("telescope.pickers").new({}, {
                prompt_title = "Harpoon",
                finder = require("telescope.finders").new_table({
                    results = file_paths,
                }),
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
            }):find()
        end

        local list = function()
            return harpoon:list()
        end

        -- Harpoon keymaps
        vim.keymap.set("n", "<leader>a", function()
            list():add()
        end, { desc = "Harpoon: Add file" })

        vim.keymap.set("n", "<C-e>", function()
            toggle_telescope(list())
        end, { desc = "Harpoon: Telescope UI" })

        vim.keymap.set("n", "<leader>e", function()
            harpoon.ui:toggle_quick_menu(list())
        end, { desc = "Harpoon: Toggle quick menu" })

        vim.keymap.set("n", "<C-h>", function()
            list():select(1)
        end, { desc = "Harpoon: Select file 1" })

        vim.keymap.set("n", "<C-t>", function()
            list():select(2)
        end, { desc = "Harpoon: Select file 2" })

        vim.keymap.set("n", "<C-n>", function()
            list():select(3)
        end, { desc = "Harpoon: Select file 3" })

        vim.keymap.set("n", "<C-s>", function()
            list():select(4)
        end, { desc = "Harpoon: Select file 4" })

        vim.keymap.set("n", "<C-S-P>", function()
            list():prev()
        end, { desc = "Harpoon: Prev buffer" })

        vim.keymap.set("n", "<C-S-N>", function()
            list():next()
        end, { desc = "Harpoon: Next buffer" })
    end,
}
