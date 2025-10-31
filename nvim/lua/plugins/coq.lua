return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    { "ms-jpq/coq_nvim", branch = "coq" },
    { "ms-jpq/coq.artifacts", branch = "artifacts" },
    { "ms-jpq/coq.thirdparty", branch = "3p" },
  },
  init = function()
    vim.g.coq_settings = {
      auto_start = "shut-up",
    }
  end,
  config = function()
    -- Load coq
    local coq = require("coq")

    -- Load 3rd party sources
    require("coq_3p") {
      { src = "copilot", short_name = "COP", accept_key = "<C-J>" },
    }

    -- Example: attach LSP with COQ
    local lsp = require("lspconfig")
    lsp.lua_ls.setup(coq.lsp_ensure_capabilities({}))
  end,
}

