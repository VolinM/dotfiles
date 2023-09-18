-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- local function NewLineInsertExpr(isUndoCount, command)
--   if not vim.v.count or vim.v.count == 0 then
--     return command
--   end
--
--   local reverse = { o = "O", O = "o" }
--
--   -- First insert a temporary '$' marker at the next line (which is necessary
--   -- to keep the indent from the current line), then insert <count> empty lines
--   -- in between. Finally, go back to the previously inserted temporary '$' and
--   -- enter insert mode by substituting this character.
--   -- Note: <C-\><C-n> prevents a move back into insert mode when triggered via
--   -- |i_CTRL-O|.
--   return (isUndoCount and vim.v.count > 0 and vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, true, true) or "")
--     .. command
--     .. "$<Esc>m`"
--     .. vim.v.count
--     .. reverse[command]
--     .. "<Esc>"
--     .. 'g``"_s'
-- end
--
-- function s_o()
--   return NewLineInsertExpr(1, "o")
-- end
--
-- function s_O()
--   return NewLineInsertExpr(1, "O")
-- end
--
-- vim.api.nvim_set_keymap("n", "o", ":lua s_o()<CR>", { silent = true, expr = true })
-- vim.api.nvim_set_keymap("n", "O", ":lua s_O()<CR>", { silent = true, expr = true })

vim.keymap.set(
  "n",
  "<leader>sx",
  require("telescope.builtin").resume,
  { noremap = true, silent = true, desc = "Resume" }
)

-- sprint to begining or end in insert mode
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
