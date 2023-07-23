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
  [[<Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR> ]]
)
-- vim.keymap.set(
--   "n",
--   "<C-f>",
--   [[: silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>]]
--)

-- sprint to begining or end in insert mode
map("i", "<S-Right>", "<Esc>$a")
map("i", "<S-Left>", "<Esc>^i")
-- keep cursor centered while jumping
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map({ "n", "v" }, "<Del>", '"_<Del>')
map("n", "<C-q>", "<cmd>qa<cr>", { desc = "Quit all" })
