return{
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    -- Ignore binary files
    local actions = require "telescope.actions"
    local previewers = require("telescope.previewers")
    local Job = require("plenary.job")
    local new_maker = function(filepath, bufnr, opts)
      filepath = vim.fn.expand(filepath)
      Job:new({
        command = "file",
        args = { "--mime-type", "-b", filepath },
        on_exit = function(j)
          local mime_type = vim.split(j:result()[1], "/")[1]
          if mime_type == "text" then
            previewers.buffer_previewer_maker(filepath, bufnr, opts)
          else
            -- maybe we want to write something to the buffer here
            vim.schedule(function()
              vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
            end)
          end
        end
      }):sync()
    end


    require("telescope").setup{
      defaults = {
        buffer_previewer_maker = new_maker,
        previewer = {
          treesitter = true,
        },
      },

      -- TODO: fix selection not with tabulation, it thinks that this file select when go next, incorrect
      -- Need new keys those mark file as selected
      extensions = {
        file_browser = {
          theme = "ivy",
          hijack_netrw = true,
          mappings = {
            ["i"] = {
              ["<Tab>"] = actions.move_selection_worse,
              ["<S-Tab>"] = actions.move_selection_better,
              ["<a-cr>"] = actions.toggle_selection,
            },
            ["n"] = {
              ["<Tab>"] = actions.move_selection_worse,
              ["<S-Tab>"] = actions.move_selection_better,
              ["<a-cr>"] = actions.toggle_selection,
            },
          },
        },
      },
    }
    require("telescope").load_extension("file_browser")
  end,

  keys = function()
    -- Telescope file-browser extention
    vim.keymap.set("n", "<leader>d", "<cmd>Telescope file_browser<CR>", { desc = 'Telescope file_browser' })
    -- Open file_browser with the path of the current buffer
    vim.keymap.set("n", "<leader>D", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", { desc = 'Telescope file_brouser buf pwd' })
  end,
}
