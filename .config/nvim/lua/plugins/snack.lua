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
    -- FIX: unexpected not fold-like indent line
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
    -- FIX: after wrong line submit 130 err on end ctrl+d
    --
    -- TODO: 
    -- 1. Add resize terminal according to ratio window size
    -- 2. Add toggle all terminals (or at least hide)
    -- 3. Connect with wich case to toggle (terminal show last cmd or current working cmd
    -- 4. Understand 
    terminal = {
      enabled = true,
      win= {
        height = 0.2,
        style = "normal",
      },
      keys = {
        gf = false,
      }
    },
  },
  keys = function ()
    -- Lazygit
    vim.keymap.set("n", "<leader>ss", "<cmd>lua Snacks.lazygit()<cr>", { desc = "Lazygit open" })
    vim.keymap.set("n", "<leader>sa", "<cmd>lua Snacks.lazygit.log()<cr>", { desc = "Lazygit open log" })
    vim.keymap.set("n", "<leader>sd", "<cmd>lua Snacks.lazygit.log_file()<cr>", { desc = "Lazygit open current file log" })

    -- Terminal
    vim.keymap.set("n", "<leader>sn", "<cmd>lua Snacks.terminal.open()<cr>", { desc = "Terminal open" })
    vim.keymap.set("n", "<leader>sm", "<cmd>lua Snacks.terminal.toggle()<cr>", { desc = "Terminal toggle" })
    vim.keymap.set("n", "<leader>s,", "<cmd>lua Snacks.terminal.get()<cr>", { desc = "Terminal get" })
  end
}
