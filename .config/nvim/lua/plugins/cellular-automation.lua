return{
  "Eandrju/cellular-automaton.nvim",
  build = 'make',
  config = function()

    local map = vim.keymap.set
    map("n", "<leader>ml", "<cmd>CellularAutomaton make_it_rain<CR>")
  end
}
