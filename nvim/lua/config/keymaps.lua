local M = {}

function M.setup()
    -- 🔹 Neovim Keymaps
    local defaults = { noremap = true, silent = true }
    vim.keymap.set('n', '<leader>C', ':keepjumps normal! ggyG<cr>', defaults) -- Select all text in the current buffer
    --
    -- Terminal
    local opts = {buffer = 0}
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    vim.keymap.set("v", "<space>s", function()
        require("toggleterm").send_lines_to_terminal("visual_selection",true, { args = vim.v.count })
    end)
    --
    -- Resize buffers
    vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", defaults)
    vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", defaults)
    vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", defaults)
    vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", defaults)
    vim.keymap.set("t", "<C-Up>", "<cmd>resize -2<CR>", defaults)
    vim.keymap.set("t", "<C-Down>", "<cmd>resize +2<CR>", defaults)
    vim.keymap.set("t", "<C-Left>", "<cmd>vertical resize -2<CR>", defaults)
    vim.keymap.set("t", "<C-Right>", "<cmd>vertical resize +2<CR>", defaults)
    --
    -- LSP
    vim.keymap.set("n", "<leader>gd", ":lua vim.lsp.buf.definition()<CR>", defaults)
    vim.keymap.set("n", "<leader>gi", ":lua vim.lsp.buf.implementation()<CR>", defaults)
    vim.keymap.set("n", "K", ":lua vim.lsp.buf.hover()<CR>", defaults)
    vim.keymap.set("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>", defaults)
    vim.keymap.set("n", "<leader>gr", ":lua vim.lsp.buf.references()<CR>", defaults)
    local keymap = vim.keymap -- for conciseness
    --
    -- use jk to exit insert mode
    keymap.set("i", "jk", "<ESC>")
    --
    -- clear search highlights
    keymap.set("n", "<ESC>", ":nohl<CR>")
    --
    -- window management
    keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
    keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
    keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
    keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window
    keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
    keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
    keymap.set("n", "<leader>tl", ":tabn<CR>") --  go to next tab
    keymap.set("n", "<leader>th", ":tabp<CR>") --  go to previous tab
    keymap.set("t", "<leader>sv", "<C-w>v") -- split window vertically
    keymap.set("t", "<leader>sh", "<C-w>s") -- split window horizontally
    keymap.set("t", "<leader>se", "<C-w>=") -- make split windows equal width & height
    keymap.set("t", "<leader>sx", ":close<CR>") -- close current split window
    keymap.set("t", "<leader>to", ":tabnew<CR>") -- open new tab
    keymap.set("t", "<leader>tx", ":tabclose<CR>") -- close current tab
    keymap.set("t", "<leader>tl", ":tabn<CR>") --  go to next tab
    keymap.set("t", "<leader>th", ":tabp<CR>") --  go to previous tab
    --
    -- Move selected line / block of text in visual mode
    keymap.set("v", "J", ":m '>+1<CR>gv=gv")
    keymap.set("v", "K", ":m '<-2<CR>gv=gv")

    -- 🔹 LSP Keymap (d)
    vim.keymap.set('n', '<Leader>dl', function()
        local new_config = not vim.diagnostic.config().virtual_lines
        vim.diagnostic.config({ virtual_lines = new_config })
    end, { desc = 'Toggle diagnostic virtual_lines' })

    -- 🔹 ToggleTerm Keymap (~)
    function M.set_toggleterm_keymaps(term_bufnr)
        local opts = { buffer = term_bufnr, silent = true }
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
        vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
    end



    -- 🔹 Harpoon Keymaps (h)
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

        vim.keymap.set("n", "<leader>fH", function()
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

    -- 🔹 neoclip (p)
    vim.keymap.set('n', '<Leader>p', function()
        vim.cmd('Telescope neoclip')
    end, { desc = 'Open Neoclip clipboard history with Telescope' })

    -- Neotest keymaps (T)
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


    -- Nvim-tree keymaps (e)
    vim.keymap.set('n', '<leader>ee', function()
        require('nvim-tree.api').tree.toggle()
    end, { desc = 'Toggle NvimTree file explorer' })

    vim.keymap.set('n', '<leader>eE', function()
        require('nvim-tree.api').tree.focus()
    end, { desc = 'Focus NvimTree window' })


    -- Copilot keymaps (C)
    vim.keymap.set('n', '<leader>Ce', "<cmd>Copilot enable<CR>", { desc = "Enable Copilot" })
    vim.keymap.set('n', '<leader>Cd', "<cmd>Copilot disable<CR>", { desc = "Disable Copilot" })
    vim.keymap.set('i', "C-j", function()
        require("copilot.suggestion").accept()
    end, { desc = "Accept Copilot suggestion" })


    -- Telescope (f)
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
