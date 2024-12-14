return{
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  main = "todo-comments",
  -- TODO: exclude venv folder from search, many todo's sooooo annoying
  opts = {},

  keys = function()
    local todo_comment = require("todo-comments")
    local jump_keywords = { "ERROR", "TODO", "FIX", "WARNING" }

    vim.keymap.set("n", "]t", function()
      todo_comment.jump_next() -- jump_keywords)
    end, { desc = "Next todo comment" })

    vim.keymap.set("n", "[t", function()
      todo_comment.jump_prev() -- jump_keywords)
    end, { desc = "Previous todo comment" })

  end,
}
