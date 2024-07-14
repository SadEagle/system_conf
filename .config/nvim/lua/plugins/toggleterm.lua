return{
  "akinsho/toggleterm.nvim",
  -- cmd = {"ToggleTerm", "ToggleTermAll", },
  config = function()
    local toggleterm = require("toggleterm")
    toggleterm.setup()

    local map = vim.keymap.set

    map({"n"}, "<A-v>", "<cmd>ToggleTerm size=60 direction=vertical<CR>", { desc = "Open terminal"})
    map({"n"}, "<A-h>", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Open terminal"})
    map({"n"}, "<A-n>", "<cmd>ToggleTermSetName<CR>", { desc = "Select and rename terminal"})


    map({"t", "n"}, "<Esc>", "<C-\\><C-n>", { desc = "Leave terminal insert mode"})
    map('t', '<C-h>', [[<Cmd>wincmd h<CR>]], { desc = "Move terminal"})
    map('t', '<C-j>', [[<Cmd>wincmd j<CR>]], { desc = "Move terminal"})
    map('t', '<C-k>', [[<Cmd>wincmd k<CR>]], { desc = "Move terminal"})
    map('t', '<C-l>', [[<Cmd>wincmd l<CR>]], { desc = "Move terminal"})
    -- map('t', '<C-w>', [[<C-\><C-n><C-w>]], { desc = ""})
    -- map('t', 'jk', [[<C-\><C-n>]], { desc = "Leave terminal insert mode"})
  end
}
