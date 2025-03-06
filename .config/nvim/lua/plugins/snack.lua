return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- Prevent treesitter and lsp attach to bigfile
    bigfile = {
      size = 15 * 1024 * 1024, -- 15 MB
    },
    -- Delete big files without disrupt layout
    -- WARN: clean buffer dont stay empty, it became
    -- bufdelete = {},
    -- TODO: Add prettier image
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
      win = {
        height = 0.9,
        width = 0.9,
      },
    },
    -- TODO: add scroll preview window
    picker = {
      prompt = "❭ ",
      win = {
        input = {
          keys = {
            ["<Tab>"] = { "list_down", mode = { "i", "n" } },
            ["<S-Tab>"] = { "list_up", mode = { "i", "n" } },
            ["<A-CR>"] = { "select_and_next", mode = { "i", "n" } },
            ["<S-CR>"] = { "select_and_prev", mode = { "i", "n" } },
            ["<c-k>"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["<c-j>"] = { "preview_scroll_down", mode = { "i", "n" } },
          },
        },
        list = {
          keys = {
            ["<Tab>"] = "list_down",
            ["<S-Tab>"] = "list_up",
            ["<A-Enter>"] = "select_and_next",
            ["<S-Enter>"] = "select_and_prev",
            ["<c-k>"] = "preview_scroll_up",
            ["<c-j>"] = "preview_scroll_down",
          },
        },
      },
    },
    rename = {},

    -- TODO: decide do i need to change treesitter scope to this
    -- scope = {
    -- },
    -- FIX: after wrong line submit 130 err on end ctrl+d
    -- scratch = {},

    -- TODO:
    -- 1. Add resize terminal according to ratio window size
    -- 2. Add toggle all terminals (or at least hide)
    -- 3. Connect with wich case to toggle (terminal show last cmd or current working cmd
    -- 4. Understand
    terminal = {
      enabled = true,
      win = {
        height = 0.3,
        style = "normal",
      },
      keys = {
        gf = false,
      }
    },
    quickfile = {},
  },
  keys = {
    -- Lazygit
    { "<leader>dd", function() Snacks.lazygit() end,                                        desc = "Lazygit open" },
    { "<leader>ds", function() Snacks.lazygit.log_file() end,                               desc = "Lazygit open current file log" },
    { "<leader>da", function() Snacks.lazygit.log() end,                                    desc = "Lazygit open log" },

    -- Picker
    { "<leader>r",  function() Snacks.picker.resume() end,                                  desc = "Resume last picker" },
    -- { "<leader>:", function() Snacks.picker.command_history() end, des/ = "Command History" },
    -- Find
    { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
    { "<leader>fb", function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
    { "<leader>ff", function() Snacks.picker.files() end,                                   desc = "Find Files" },
    { "<leader>fg", function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
    { "<leader>fr", function() Snacks.picker.recent() end,                                  desc = "Recent" },
    -- Git
    { "<leader>gc", function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
    { "<leader>gs", function() Snacks.picker.git_status() end,                              desc = "Git Status" },
    -- Search
    { '<leader>s"', function() Snacks.picker.registers() end,                               desc = "Registers" },
    { "<leader>s:", function() Snacks.picker.command_history() end,                         desc = "Command History" },
    { "<leader>s/", function() Snacks.picker.search_history() end,                          desc = "Search History" },
    -- { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
    { "<leader>sc", function() Snacks.picker.commands() end,                                desc = "Commands" },
    { "<leader>sg", function() Snacks.picker.grep() end,                                    desc = "LiveGrep" },
    { "<leader>sh", function() Snacks.picker.help() end,                                    desc = "Help Pages" },
    -- { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
    { "<leader>sj", function() Snacks.picker.jumps() end,                                   desc = "Jumps" },
    -- { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    -- { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
    -- TODO: add float window man, useless useless
    { "<leader>sM", function() Snacks.picker.man() end,                                     desc = "Man Pages" },
    { "<leader>sm", function() Snacks.picker.marks() end,                                   desc = "Marks" },
    -- TODO: check usecases
    -- { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
    -- FIX: colorscheme expect another colorschme path param to change it
    -- { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
    { "<leader>p",  function() Snacks.picker.projects() end,                                desc = "Projects" },
    -- LSP
    -- TODO: add diagnostic without WARN
    { "<leader>lx", function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
    { "<leader>lX", function() Snacks.picker.diagnostics_buffer() end,                      desc = "Diagnostics buffer" },
    { "<leader>ld", function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
    { "<leader>lr", function() Snacks.picker.lsp_references() end,                          nowait = true,                         desc = "References" },
    { "<leader>li", function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
    { "<leader>ly", function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },
    { "<leader>ls", function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
    -- Rename LSP
    { "<leader>lm", function() Snacks.rename.rename_file() end,                             desc = "Rename file lsp" },

    -- -- Scratch
    -- { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    -- { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },

    -- Terminal
    -- TODO: add toggle all
    { "<leader>dm", function() Snacks.terminal.open() end,                                  desc = "Terminal open" },
    { "<leader>d,", function() Snacks.terminal.toggle() end,                                desc = "Terminal toggle" },
  },
}
