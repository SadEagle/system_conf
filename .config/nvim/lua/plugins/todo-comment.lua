return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    -- require'telescope.builtin'.buffers{ show_all_buffers = true }

    local todo_comments = require("todo-comments")

    -- set keymaps
    local map = vim.keymap.set

    map("n", "]t", function()
      todo_comments.jump_next()
    end, { desc = "Next todo comment" })

    map("n", "[t", function()
      todo_comments.jump_prev()
    end, { desc = "Previous todo comment" })

    todo_comments.setup()
  end,
}
