local M = {
  "linux-cultist/venv-selector.nvim",
  ft = { "py", "python", "jupyter", "ipynb" },
  cmd = "VenvSelect",
  opts = {},
  keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" } },
}
return M
