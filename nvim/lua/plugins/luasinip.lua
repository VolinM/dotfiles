local next_char = vim.fn.getline(vim.fn.line(".")):sub(vim.fn.col("."), vim.fn.col("."))

local M = {
  "L3MON4D3/LuaSnip",
  opts = {
    history = false,
    delete_check_events = "TextChanged",
    enable_autosnippets = true,
    store_selection_keys = "<Tab>",
    update_events = "TextChanged,TextChangedI",
  },
  -- stylua: ignore
  keys = {
    {
      "<tab>",
      function()
        next_char = vim.fn.getline(vim.fn.line(".")):sub(vim.fn.col("."), vim.fn.col("."))
        if next_char == ")" then
          return "<Right>"
        else
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end
      end,
      expr = true,
      silent = true,
      mode = "i",
    },
    {
      "<tab>",
      function()
        require("luasnip").jump(1)
      end,
      mode = "s",
    },
    {
      "<s-tab>",
      function()
        require("luasnip").jump(-1)
      end,
      mode = { "i", "s" },
    },
  },
}

return M
