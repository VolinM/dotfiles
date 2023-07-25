-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

vim.keymap.set(
  "n",
  "<leader>sx",
  require("telescope.builtin").resume,
  { noremap = true, silent = true, desc = "Resume" }
)

vim.keymap.set(
  "i",
  "<C-f>",
  [[<Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'lua=vim.b.vimtex.root.'/figures/"'<CR><CR>:w<CR> ]]
)
-- vim.keymap.set(
--   "n",
--   "<C-f>",
--   [[: silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>]]
--)

-- sprinet to begining or end in insert mode
map("i", "<S-Right>", "<Esc>$a")
map("i", "<S-Left>", "<Esc>^i")
-- keep cursor centered while jumpin"
map("n", "<C-d>", "<C-d>zz", { remap = false })
map("n", "<C-u>", "<C-u>zz", { remap = false })
map("n", "n", "nzz", { remap = false })
map("n", "N", "Nzz", { remap = false })
-- <del> key goes into the blanq buffer
map({ "n", "v", "s" }, "<Del>", '"_<Del>')
map({ "i", "n", "v", "s" }, "<C-q>", "<cmd>qa<cr>", { desc = "Quit all" })
