return{
  "OXY2DEV/markview.nvim",
  ft = "markdown",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons"
  },
  options = function ()
    local markview = require("markview")
    markview.setup()

    local map = vim.keymap.set
    -- TODO: make hotkey for splitted vindow markdown 
    map("n", "<leader>mv", "<cmd>Markview<CR>", { desc = "Preview markdown" })
  end,
}
