local M = {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      pyright = {},
      ruff_lsp = {},
      texlab = {
        keys = {
          { "<Leader>K", "<plug>(vimtex-doc-package)", desc = "Vimtex Docs", silent = true },
        },
      },
    },
  },
  setup = {
    ruff_lsp = function()
      require("lazyvim.util").on_attach(function(client, _)
        if client.name == "ruff_lsp" then
          -- Disable hover in favor of Pyright
          client.server_capabilities.hoverProvider = false
        end
      end)
    end,
  },
}
return M
