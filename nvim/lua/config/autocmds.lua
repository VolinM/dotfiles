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
  callback = function(event)
    vim.opt_local.spell = true
    vim.keymap.set("i", "<C-l>", "<Esc>[s1z=`]a", { buffer = event.buf })
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.list = false
    vim.keymap.set("i", "<C-u>", "underl", { buffer = event.buf })
    vim.keymap.set("i", "<C-j>", "textit", { buffer = event.buf })
    vim.keymap.set("n", "<leader>li", "<plug>(vimtex-info)<CR>", { buffer = event.buf, desc = "Info" })
    vim.keymap.set("n", "<leader>lI", "<plug>(vimtex-info-full)<CR>", { buffer = event.buf, desc = "Info Full" })
    vim.keymap.set("n", "<leader>lt", "<plug>(vimtex-toc-open)<CR>", { buffer = event.buf, desc = "TOC Open" })
    vim.keymap.set("n", "<leader>lT", "<plug>(vimtex-toc-toggle)<CR>", { buffer = event.buf, desc = "TOC Toggle" })
    vim.keymap.set("n", "<leader>ly", "<plug>(vimtex-labels-open)<CR>", { buffer = event.buf, desc = "Labels Open" })
    vim.keymap.set(
      "n",
      "<leader>lY",
      "<plug>(vimtex-labels-toggle)<CR>",
      { buffer = event.buf, desc = "Labels Toggle" }
    )
    vim.keymap.set("n", "<leader>lv", "<plug>(vimtex-view)<CR>", { buffer = event.buf, desc = "View" })
    vim.keymap.set(
      "n",
      "<leader>lr",
      "<plug>(vimtex-reverse-search)<CR>",
      { buffer = event.buf, desc = "Reverse Search" }
    )
    vim.keymap.set("n", "<leader>ll", "<plug>(vimtex-compile-ss)<CR>", { buffer = event.buf, desc = "Compile Toggle" })
    vim.keymap.set("n", "<leader>lk", "<plug>(vimtex-stop)<CR>", { buffer = event.buf, desc = "Stop" })
    vim.keymap.set("n", "<leader>lK", "<plug>(vimtex-stop-all)<CR>", { buffer = event.buf, desc = "Stop All" })
    vim.keymap.set("n", "<leader>le", "<plug>(vimtex-errors)<CR>", { buffer = event.buf, desc = "Errors" })
    vim.keymap.set(
      "n",
      "<leader>lo",
      "<plug>(vimtex-compile-output)<CR>",
      { buffer = event.buf, desc = "Compile Output" }
    )
    vim.keymap.set("n", "<leader>lg", "<plug>(vimtex-status)<CR>", { buffer = event.buf, desc = "Status" })
    vim.keymap.set("n", "<leader>lG", "<plug>(vimtex-status-all)<CR>", { buffer = event.buf, desc = "Status All" })
    vim.keymap.set("n", "<leader>lc", "<plug>(vimtex-clean)<CR>", { buffer = event.buf, desc = "Clean" })
    vim.keymap.set("n", "<leader>lC", "<plug>(vimtex-clean-full)<CR>", { buffer = event.buf, desc = "Clean Full" })
    vim.keymap.set("n", "<leader>lm", "<plug>(vimtex-imaps-list)<CR>", { buffer = event.buf, desc = "Imaps List" })
    vim.keymap.set("n", "<leader>lx", "<plug>(vimtex-reload)<CR>", { buffer = event.buf, desc = "Reload" })
    vim.keymap.set("n", "<leader>ls", "<plug>(vimtex-toggle-main)<CR>", { buffer = event.buf, desc = "Toggle Main" })
  end,
})
