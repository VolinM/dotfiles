local M = {
  "lervag/vimtex",
  ft = { "latex", "tex", "plaintex" },
  config = function()
    vim.g.vimtex_imaps_enabled = 0 -- diable inser mode mappings
    vim.g.vimtex_view_method = "zathura"
  end,
}

return M
