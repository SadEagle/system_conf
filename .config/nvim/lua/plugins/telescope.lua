return{
  "nvim-telescope/telescope.nvim",
  tag = '0.1.8',
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons"
  },
  main = "telescope",
  config = function(PluginSpec)
    local actions = require("telescope.actions")
    
    -- Ignore binary files
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


    require(PluginSpec.main).setup{
      -- Workaround to set global theme
      -- https://github.com/nvim-telescope/telescope.nvim/issues/938#issuecomment-877539724
      defaults = { --require("telescope.themes").get_dropdown{
        buffer_previewer_maker = new_maker,
        -- path_display = { "shorten" },
        sorting_strategy = "ascending",
        layout_strategy = "center",
        previewer = {
          treesitter = true,
        },
        layout_config = {
          -- TODO: change width and height dynamical connected with size (was issue). Also try change theme type proly
          center = {
            preview_cutoff = 0,
            height = 0.25,
            width = 0.7,
            preview_cutoff = 0, -- Dont hide preview every win size
          }

        },
        mappings = {
          i = {
            ["<esc>"] = actions.close,  -- Skip normal mode telescope
            -- Go across history
            ["<c-j>"] = actions.cycle_history_next,
            ["<c-k>"] = actions.cycle_history_prev,
          },
          -- TODO: dont show lines of code near file name wtf???? it's useless because literally full code see nearside
        },
        -- -- NOTE: exclude these folders from search
        file_ignore_patterns = { "/pip/" }
      },
    }
  end,
  keys = function()
    -- Built-ins
    local builtin = require('telescope.builtin')
    -- Return last position telescope    
    vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'Telescope restore last state '})

    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', "<leader>f'", builtin.marks, { desc = 'Telescope marks'})
    vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'Telescope previously open files' })
    vim.keymap.set('n', '<leader>f:', builtin.command_history, { desc = 'Telescope cmd history' })
    vim.keymap.set('n', '<leader>f/', builtin.search_history, { desc = 'Telescope search history' })
    vim.keymap.set('n', '<leader>fj', builtin.jumplist, { desc = 'Telescope jumplist' })
    -- vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

    -- Todo-comments.nvim
    vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Telescope todo" })
    -- vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope keywords=TODO,FIX,WARNING,ERROR<cr>", { desc = "Telescope todo" })

    -- LSP
    -- Calls current function include initialisation (first line)
    vim.keymap.set("n", "<leader>lr", builtin.lsp_references, {desc = ' Telescope lsp ref cursor word ' })
    -- Calls current object exclude initialisation
    vim.keymap.set("n", "<leader>li", builtin.lsp_incoming_calls, {desc = ' Telescope lsp cur obj calls ' })
    -- Callable objects inside current object body. Also ignore
    -- FIX: include strange lines for built-in function like print
    vim.keymap.set("n", "<leader>lo", builtin.lsp_outgoing_calls, {desc = ' Telescope lsp inside callable objects ' })
    vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols, {desc = ' Telescope lsp cur buffer objects' })
    vim.keymap.set("n", "<leader>lw", builtin.lsp_dynamic_workspace_symbols, {desc = ' Telescope lsp workdir objects' })
    vim.keymap.set("n", "<leader>ld", builtin.diagnostics, {desc = ' Telescope diagnostic ' })
    -- FIX: dont work dont know why
    -- vim.keymap.set("n", "<leader>lp", builtin.lsp_implementations, {desc = ' Telescope lsp ref cursor word' })
    -- vim.keymap.set("n", "<leader>lf", builtin.lsp_definitions, {desc = ' Telescope lsp ref cursor word' })
    -- vim.keymap.set("n", "<leader>lt", builtin.lsp_type_definitions, {desc = ' Telescope lsp ref cursor word' })

  end,
}
