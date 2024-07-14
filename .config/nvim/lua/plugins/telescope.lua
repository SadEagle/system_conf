return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
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

    -- set keymaps
    local map = vim.keymap.set

    map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy telescope files in cwd" })
    map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy telescope recent files" })
    map("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Telescope string in cwd" })
    map("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Telescope string under cursor in cwd" })
    map("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Telescope todos" })

    -- Custom
    map("n", "<leader>fb", "<cmp>Telescope buffers<cr>", { desc = "Telescope across buffers"})
    map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
    map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "Telescope git commits" })
    map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "Telescope git status" })
  end,
}
