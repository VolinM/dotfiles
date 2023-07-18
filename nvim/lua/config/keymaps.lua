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

vim.keymap.set({ "i", "s" }, "<A-e>", function()
  if require("luasnip").choice_active() then
    require("luasnip").change_choice(1)
  end
end, { silent = true })

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
--
map("i", "<S-Right>", "<Esc>$a")
map("i", "<S-Left>", "<Esc>^i")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
