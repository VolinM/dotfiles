-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local map = vim.keymap.set

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

local acmd = vim.api.nvim_create_autocmd

-- autocomands for tex files
acmd("FileType", {
  group = augroup("spell_&_wrap"),
  pattern = { "tex", "latex", "plaintex" },
  callback = function(event)
    -- spell check and correction
    vim.opt_local.spell = true
    map("i", "<C-l>", "<Esc>[s1z=`]a", { buffer = event.buf }) -- autocorrect last with ctrl-l
    -- wrap
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.list = false
    --
    map({ "n", "v" }, "j", "gj", { noremap = true })
    map({ "n", "v" }, "k", "gk", { noremap = true })
    map({ "n", "v" }, "0", "g^", { noremap = true })
    map({ "n", "v" }, "$", "g$", { noremap = true })
    map({ "n", "v" }, "gk", "k", { noremap = true })
    map({ "n", "v" }, "gj", "j", { noremap = true })
    map({ "n", "v" }, "g^", "0", { noremap = true })
    map({ "n", "v" }, "g$", "$", { noremap = true })
    -- helpers for luasnip
    map({ "i", "v", "n", "s" }, "<F12>", "<esc><C-j><cmd>q<cr>", { buffer = event.buf, remap = true }) -- kill compile fail with F12
    map("i", "<C-u>", "underl", { buffer = event.buf }) -- helper for underline
    map("i", "<C-j>", "textit", { buffer = event.buf }) -- helper for italics
    map({ "i", "s" }, "æ", function() -- helper to switch luasnip choices
      if require("luasnip").choice_active() then
        require("luasnip").change_choice(1)
      end
    end, { silent = true })
    -- redefining vimtex plugins
    map("n", "<leader>li", "<plug>(vimtex-info)<CR>", { buffer = event.buf, desc = "Info" })
    map("n", "<leader>lI", "<plug>(vimtex-info-full)<CR>", { buffer = event.buf, desc = "Info Full" })
    map("n", "<leader>lt", "<plug>(vimtex-toc-open)<CR>", { buffer = event.buf, desc = "TOC Open" })
    map("n", "<leader>lT", "<plug>(vimtex-toc-toggle)<CR>", { buffer = event.buf, desc = "TOC Toggle" })
    map("n", "<leader>ly", "<plug>(vimtex-labels-open)<CR>", { buffer = event.buf, desc = "Labels Open" })
    map("n", "<leader>lY", "<plug>(vimtex-labels-toggle)<CR>", { buffer = event.buf, desc = "Labels Toggle" })
    map("n", "<leader>lv", "<plug>(vimtex-view)<CR>", { buffer = event.buf, desc = "View" })
    map("n", "<leader>lr", "<plug>(vimtex-reverse-search)<CR>", { buffer = event.buf, desc = "Reverse Search" })
    map("n", "<leader>ll", "<plug>(vimtex-compile-ss)<CR>", { buffer = event.buf, desc = "Compile Toggle" })
    map("n", "<leader>lk", "<plug>(vimtex-stop)<CR>", { buffer = event.buf, desc = "Stop" })
    map("n", "<leader>lK", "<plug>(vimtex-stop-all)<CR>", { buffer = event.buf, desc = "Stop All" })
    map("n", "<leader>le", "<plug>(vimtex-errors)<CR>", { buffer = event.buf, desc = "Errors" })
    map("n", "<leader>lo", "<plug>(vimtex-compile-output)<CR>", { buffer = event.buf, desc = "Compile Output" })
    map("n", "<leader>lg", "<plug>(vimtex-status)<CR>", { buffer = event.buf, desc = "Status" })
    map("n", "<leader>lG", "<plug>(vimtex-status-all)<CR>", { buffer = event.buf, desc = "Status All" })
    map("n", "<leader>lc", "<plug>(vimtex-clean)<CR>", { buffer = event.buf, desc = "Clean" })
    map("n", "<leader>lC", "<plug>(vimtex-clean-full)<CR>", { buffer = event.buf, desc = "Clean Full" })
    map("n", "<leader>lm", "<plug>(vimtex-imaps-list)<CR>", { buffer = event.buf, desc = "Imaps List" })
    map("n", "<leader>lx", "<plug>(vimtex-reload)<CR>", { buffer = event.buf, desc = "Reload" })
    map("n", "<leader>ls", "<plug>(vimtex-toggle-main)<CR>", { buffer = event.buf, desc = "Toggle Main" })
    map(
      { "i", "v", "n", "s" },
      "<C-c>",
      "<cmd>w<cr><esc><plug>(vimtex-compile)<CR>",
      { buffer = event.buf, remap = false }
    )
  end,
})
