return {
    "github/copilot.vim",
    "CopilotC-Nvim/CopilotChat.nvim",
    build = "make tiktoken",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    config = function()
    end,
}
