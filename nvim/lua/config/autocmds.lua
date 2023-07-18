-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

local acmd = vim.api.nvim_create_autocmd

acmd("FileType", {
  group = augroup("spell_&_wrap"),
  pattern = { "tex", "latex", "plaintex" },
  callback = function()
    vim.opt_local.spell = true
    vim.keymap.set("i", "<C-l>", "<Esc>[s1z=`]a")
  end,
})
