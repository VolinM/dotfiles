local M = {
  "kiyoon/jupynium.nvim",
  ft = { "py", "python", "jupyter", "ipynb" },
  build = "pip3 install --user .",
  -- build = "conda run --no-capture-output -n jupynium pip install .",
  -- enabled = vim.fn.isdirectory(vim.fn.expand "~/miniconda3/envs/jupynium"),
}

return M
