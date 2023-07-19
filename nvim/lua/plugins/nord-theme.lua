return {
  -- add gruvbox
  {
    "arcticicestudio/nord-vim",
    config = function()
      vim.g.nord_borders = true
      vim.g.nord_diable_background = true
    end,
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nord",
    },
  },
}
