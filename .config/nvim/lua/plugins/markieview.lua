return{
  "OXY2DEV/markview.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons"
  },
  options = function ()
    local markieview = require("marikeview")
    markieview.setup()

    local map = vim.keymap.set
    -- TODO: make hotkey for splitted vindow markdown 
    map("n", "<leader>mv", "<cmd>Markview<CR>", { desc = "Preview markdown" })
  end,
}
