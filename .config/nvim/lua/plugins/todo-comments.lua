return{
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  main = "todo-comments",
  opts = {},

  keys = {
    { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo all" },
    { "<leader>sT", function () Snacks.picker.todo_comments({ keywords = { "TODO", "FIX"} }) end, desc = "Todo/Fix" },
  },
}
