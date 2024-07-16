return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    "nvim-tree/nvim-web-devicons",
    -- Extend functional
    "folke/todo-comments.nvim",
    "folke/noice.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local transform_mod = require("telescope.actions.mt").transform_mod

    local trouble = require("trouble")
    local trouble_telescope = require("trouble.providers.telescope")

    -- or create your custom action
    local custom_actions = transform_mod({
      open_trouble_qflist = function(prompt_bufnr)
        trouble.toggle("quickfix")
      end,
    })

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            -- TODO: what is this?
            -- ["<C-t>"] = trouble_telescope.open,
          },
        },
      },
      extentions = {
        fzf = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = true,  -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        }
      }
    })

    telescope.load_extension("fzf")
    telescope.load_extension("noice")

    -- set keymaps
    local map = vim.keymap.set
    local default_theme = " theme=get_dropdown "

    map("n", "<leader>ff", "<cmd>Telescope find_files" .. default_theme .. "<cr>", { desc = "Fuzzy telescope files in cwd" })
    map("n", "<leader>fr", "<cmd>Telescope oldfiles" .. default_theme .. "<cr>", { desc = "Fuzzy telescope recent files" })
    map("n", "<leader>fs", "<cmd>Telescope live_grep" .. default_theme .. "<cr>", { desc = "Telescope string in cwd" })
    map("n", "<leader>fc", "<cmd>Telescope grep_string" .. default_theme .. "<cr>", { desc = "Telescope string under cursor in cwd" })
    map("n", "<leader>ft", "<cmd>TodoTelescope" .. default_theme .. "<cr>", { desc = "Telescope todos" })

    -- Custom
    map("n", "<leader>fb", "<cmp>Telescope buffers" .. default_theme .. "<cr>", { desc = "Telescope across buffers"})
    map("n", "<leader>fn", "<cmd>Telescope notify" .. default_theme .. "<CR>", { desc = "Telescope all notifies"})

    map("n", "<leader>ma", "<cmd>Telescope marks" .. default_theme .. "<CR>", { desc = "telescope find marks" })
    map("n", "<leader>gc", "<cmd>Telescope git_commits" .. default_theme .. "<CR>", { desc = "Telescope git commits" })
    map("n", "<leader>gs", "<cmd>Telescope git_status" .. default_theme .. "<CR>", { desc = "Telescope git status" })
  end,
}
