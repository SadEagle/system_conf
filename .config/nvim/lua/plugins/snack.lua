return{
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- Prevent treesitter and lsp attach to bigfile
    bigfile = {
      size = 15* 1024 * 1024, -- 15 MB
    },
    -- Delete big files without disrupt layout
    -- WARN: clean buffer dont stay empty, it became 
    -- bufdelete = {},
    dashboard = {
      sections = {
        { section = "header" },
        { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        { section = "startup" },
      },
    },
    -- TODO: change indent-lines to snak indent
    -- indent = {
    -- },

    lazygit = {
      win= {
        height = 0.9,
        width = 0.9,
      },
    },
    -- TODO: decide do i need to change treesitter scope to this
    -- scope = {
    -- },
    -- FIX: default settings dont transfer inside terminal
    -- Dont store cmds inside history
    --
    -- FIX: this looks terrible
    -- terminal = {
    --   enabled = true,
    --   win= {
    --     height=0.2,
    --   },
    --   keys = {
    --     gf = false,
    --   }
    -- },
  },
  keys = function ()
    -- Lazygit
    vim.keymap.set("n", "<leader>ss", "<cmd>lua Snacks.lazygit()<cr>", { desc = "Lazygit open" })
    -- vim.keymap.set("n", "<leader>sl", "<cmd>lua Snacks.lazygit.log()<cr>", { desc = "Lazygit open log" })
    -- vim.keymap.set("n", "<leader>sf", "<cmd>lua Snacks.lazygit.log_file()<cr>", { desc = "Lazygit open current file log" })

    -- Terminal
    -- vim.keymap.set("n", "<leader>so", "<cmd>lua Snacks.terminal.open()<cr>", { desc = "Terminal open" })
    -- vim.keymap.set("n", "<leader>t", "<cmd>lua Snacks.terminal.toggle()<cr>", { desc = "Terminal toggle" })
    -- vim.keymap.set("n", "<leader>sg", "<cmd>lua Snacks.terminal.get()<cr>", { desc = "Terminal get" })
  end
}
