local M = {
  {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({
        exclude = { "tex", "latex" },
      })
    end,
  },
  { "echasnovski/mini.pairs", enabled = false },
}

return M
