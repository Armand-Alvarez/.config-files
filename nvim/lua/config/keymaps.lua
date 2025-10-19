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

    -- 🔹 neoclip
    vim.keymap.set('n', '<Leader>p', function()
        vim.cmd('Telescope neoclip')
    end, { desc = 'Open Neoclip clipboard history with Telescope' })

    -- Neotest keymaps
    local neotest = require("neotest")

    vim.keymap.set('n', '<leader>Tn', function() neotest.run.run() end, { desc = "Run nearest test" })
    vim.keymap.set('n', '<leader>Tf', function() neotest.run.run(vim.fn.expand('%')) end, { desc = "Run current file" })
    vim.keymap.set('n', '<leader>Ta', function() neotest.run.run({ suite = true }) end, { desc = "Run all tests" })
    vim.keymap.set('n', '<leader>Td', function() neotest.run.run({ strategy = "dap" }) end, { desc = "Debug nearest test" })
    vim.keymap.set('n', '<leader>TS', function() neotest.run.stop() end, { desc = "Stop test" })
    vim.keymap.set('n', '<leader>Tn', function() neotest.run.attach() end, { desc = "Attach to nearest test" })
    vim.keymap.set('n', '<leader>TO', function() neotest.output.open() end, { desc = "Show test output" })
    vim.keymap.set('n', '<leader>To', function() neotest.output_panel.toggle() end, { desc = "Toggle output panel" })
    vim.keymap.set('n', '<leader>Ts', function() neotest.summary.toggle() end, { desc = "Toggle summary" })
    vim.keymap.set('n', '<leader>Tc', function() neotest.run.run({ suite = true, env = { CI = true } }) end, { desc = "Run all tests with CI" })


    -- Nvim-tree keymaps
    vim.keymap.set('n', '<leader>ee', function()
        require('nvim-tree.api').tree.toggle()
    end, { desc = 'Toggle NvimTree file explorer' })

    vim.keymap.set('n', '<leader>eE', function()
        require('nvim-tree.api').tree.focus()
    end, { desc = 'Focus NvimTree window' })


    -- Telescope
    vim.keymap.set('n', '<leader>ff', function()
        require('telescope.builtin').find_files()
    end, { desc = "Telescope: Find files" })

    vim.keymap.set('n', '<leader>fg', function()
        require('telescope.builtin').live_grep()
    end, { desc = "Telescope: Live grep" })

    vim.keymap.set('n', '<leader>fb', function()
        require('telescope.builtin').buffers()
    end, { desc = "Telescope: List buffers" })

    vim.keymap.set('n', '<leader>fh', function()
        require('telescope.builtin').help_tags()
    end, { desc = "Telescope: Help tags" })

    vim.keymap.set('n', '<leader>fo', function()
        require('telescope.builtin').oldfiles()
    end, { desc = "Telescope: Recently opened files" })

    vim.keymap.set('n', '<leader>fc', function()
        require('telescope.builtin').commands()
    end, { desc = "Telescope: Commands" })

    vim.keymap.set('n', '<leader>fk', function()
        require('telescope.builtin').keymaps()
    end, { desc = "Telescope: Keymaps" })

    vim.keymap.set('n', '<leader>fd', function()
        require('telescope.builtin').diagnostics()
    end, { desc = "Telescope: Diagnostic" })

    vim.keymap.set('n', '<leader>fs', function()
        require('telescope.builtin').builtin()
    end, { desc = "Telescope: Show built-in pickers" })

end
return M
