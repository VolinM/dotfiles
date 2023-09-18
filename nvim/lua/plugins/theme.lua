return {
  -- add gruvbox
  {
    "arcticicestudio/nord-vim",
    name = "nord",
    priority = 1000,
    config = function()
      vim.g.nord_borders = true
      vim.g.nord_diable_background = true
    end,
  },

  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  { "rose-pine/neovim", name = "rose-pine", priority = 1000 },

  { "morhetz/gruvbox", name = "gruvbox", priority = 1000 },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = 'nord',
    },
  },
}
