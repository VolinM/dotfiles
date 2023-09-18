local map = vim.keymap.set
return {
  "luk400/vim-jukit",
  ft = { "python", "py" },
  config = function()
    map("n", "<leader>jo", "<cmd>call jukit#splits#output()<cr>", { desc = "Open Jukit" })
  end,
}
