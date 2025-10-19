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
    end,
}
