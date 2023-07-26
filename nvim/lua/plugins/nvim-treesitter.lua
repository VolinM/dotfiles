local M = {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    if type(opts.ensure_installed) == "table" then
      vim.list_extend(opts.ensure_installed, { "ninja", "python", "rst", "toml" })
    end
    if type(opts.ensure_installed) == "table" then
      vim.list_extend(opts.ensure_installed, { "bibtex", "latex" })
    end
    if type(opts.highlight.disable) == "table" then
      vim.list_extend(opts.highlight.disable, { "latex" })
    else
      opts.highlight.disable = { "latex" }
    end
  end,
}
return M
