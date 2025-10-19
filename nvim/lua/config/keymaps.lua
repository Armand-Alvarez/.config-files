-- File: lua/keymaps.lua

local M = {}

function M.setup()
    -- 🔹 LSP Keymap
    vim.keymap.set('n', '<Leader>dl', function()
        local new_config = not vim.diagnostic.config().virtual_lines
        vim.diagnostic.config({ virtual_lines = new_config })
    end, { desc = 'Toggle diagnostic virtual_lines' })


    -- 🔹 Harpoon Keymaps
    local ok, harpoon = pcall(require, "harpoon")
    if ok then
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

        vim.keymap.set("n", "<leader>ha", function()
            list():add()
        end, { desc = "Harpoon: Add file" })

        vim.keymap.set("n", "<leader>th", function()
            toggle_telescope(list())
        end, { desc = "Harpoon: Telescope UI" })

        vim.keymap.set("n", "<leader>hl", function()
            harpoon.ui:toggle_quick_menu(list())
        end, { desc = "Harpoon: Toggle quick menu" })

        vim.keymap.set("n", "<leader>h1", function()
            list():select(1)
        end, { desc = "Harpoon: Select file 1" })

        vim.keymap.set("n", "<leader>h2", function()
            list():select(2)
        end, { desc = "Harpoon: Select file 2" })

        vim.keymap.set("n", "<leader>h3", function()
            list():select(3)
        end, { desc = "Harpoon: Select file 3" })

        vim.keymap.set("n", "<leader>h4", function()
            list():select(4)
        end, { desc = "Harpoon: Select file 4" })

        vim.keymap.set("n", "<leader>hh", function()
            list():prev()
        end, { desc = "Harpoon: Prev buffer" })

        vim.keymap.set("n", "<leader>hj", function()
            list():next()
        end, { desc = "Harpoon: Next buffer" })
    else
        vim.notify("Harpoon not loaded. Skipping harpoon keymaps.", vim.log.levels.WARN)
    end

    -- 🔹 Add more plugin keymaps here...
end

return M
