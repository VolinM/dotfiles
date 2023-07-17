local M = {
  {
    "hkupty/iron.nvim",
    ft = { "python", "ipython" },
    config = function()
      local iron = require("iron.core")

      iron.setup({
        config = {
          -- Whether a repl should be discarded or not
          scratch_repl = true,
          -- Your repl definitions come here
          repl_definition = {
            sh = {
              -- Can be a table or a function that
              -- returns a table (see below)
              command = { "zsh" },
            },
          },
          -- How the repl window will be displayed
          -- See below for more information
          repl_open_cmd = require("iron.view").split("40%"),
        },
        -- Iron doesn't set keymaps by default anymore.
        -- You can set them here or manually add keymaps to the functions in iron.core
        keymaps = {
          send_motion = "<space>is",
          visual_send = "<space>is",
          send_file = "<space>if",
          send_line = "<space>il",
          send_mark = "<space>im",
          mark_motion = "<space>ik",
          mark_visual = "<space>ik",
          remove_mark = "<space>id",
          cr = "<space>i<cr>",
          interrupt = "<space>i<space>",
          exit = "<space>iq",
          clear = "<space>ic",
        },
        -- If the highlight is on, you can change how it looks
        -- For the available options, check nvim_set_hl
        highlight = {
          italic = true,
        },
        ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
      })

      -- iron also has a list of commands, see :h iron-commands for all available commands
      vim.keymap.set("n", "<space>ii", "<cmd>IronRepl<cr>")
      vim.keymap.set("n", "<space>ir", "<cmd>IronRestart<cr>")
      vim.keymap.set("n", "<space>ip", "<cmd>IronFocus<cr>")
      vim.keymap.set("n", "<space>ix", "<cmd>IronHide<cr>")
    end,
  },
  {
    "GCBallesteros/jupytext.vim",
    config = function()
      vim.g.jupytext_fmt = "py"
    end,
  },
}

return M
