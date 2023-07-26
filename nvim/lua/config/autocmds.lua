-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local map = vim.keymap.set

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

local acmd = vim.api.nvim_create_autocmd

acmd("FileType", {
  group = augroup("jupyter"),
  pattern = { "ju.py", "python", "py", "ipynb" },
  callback = function(event)
    -- insert new jupyter cell
    vim.opt_local.formatoptions:remove({ "r", "o" })
    map({ "i", "n" }, "<C-n>", "<esc>i# %% \n\n", { buffer = event.buf, remap = false })
    map(
      { "i", "v", "n", "s" },
      "<C-c>",
      "<cmd>w<cr><esc><cmd>JupyniumStartAndAttachToServer<CR>",
      { buffer = event.buf, remap = false }
    )
    vim.keymap.set(
      { "n", "x" },
      "<C-x>",
      "<cmd>JupyniumExecuteSelectedCells<CR>",
      { buffer = event.buf, desc = "Jupynium execute selected cells" }
    )
  end,
})
