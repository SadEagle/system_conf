return{
  {"Eandrju/cellular-automaton.nvim", build = 'make'},
  config = function()
    local cellular_automation = require("cellular-automation")
    cellular_automation.setup()

    local map = vim.keymap.set
    map("n", "<leader>ml", "<cmd>CellularAutomaton make_it_rain<CR>")
  end
}
