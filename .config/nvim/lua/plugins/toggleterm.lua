return{
  "akinsho/toggleterm.nvim",
  cond = false,
  version = "*",
  opts = {
    size = 20,
  },
  keys = function ()
    local toggleterm = require("toggleterm")
    vim.keymap.set("n", "<leader>so", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = " Create terminal" })
    vim.keymap.set("n", "<leader>sa", "<cmd>ToggleTermAll<cr>", { desc = " Toggle all terminals" })

    -- Extra terminals
    local Terminal  = require('toggleterm.terminal').Terminal
    -- LazyGit
    local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
    function _lazygit_toggle()
      lazygit:toggle()
    end
    vim.api.nvim_set_keymap("n", "<leader>ss", "<cmd>lua _lazygit_toggle()<CR>", { desc = "LazyGit", noremap = true, silent = true})
    -- TODO: end
    -- Yazi
    local yazi = Terminal:new({ cmd = "yazi" .. " " .. vim.fn.getcwd(), hidden = true, direction = "float" })
    function _yazi()
      yazi:toggle()
    end
    vim.api.nvim_set_keymap("n", "<leader>sy", "<cmd>lua _yazi()<CR>", { desc = "Btop", noremap = true, silent = true})
    -- Btop
    local btop = Terminal:new({ cmd = "btop", hidden = true, direction = "float" })
    function _btop()
      btop:toggle()
    end
    vim.api.nvim_set_keymap("n", "<leader>sb", "<cmd>lua _btop()<CR>", { desc = "Btop", noremap = true, silent = true})
  end
}
