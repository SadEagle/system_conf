return{
  "ibhagwan/fzf-lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  main = "fzf-lua",
  opts = {
    winopts = {
      preview = {
        layout = "vertical",
        vertical = "up",
      },
    },
    previewers = { builtin = { treesitter = { context = true} } },
    -- Set in unite cmd fastest possible variants fd and rg
    files = {
      cmd = [[fd . --color=never --type f --hidden --follow --exclude .git \
              --exclude 'python*' --exclude bin --exclude lib]],
      fzf_opts = {
        ['--history'] = vim.fn.stdpath("data") .. '/fzf-lua-files-history',
      },
    },
    -- TODO: add --heading variant with unite greps by files
    -- TODO: probably swap to glob. Current algo search across full line (file name + found str)
    grep = {
      cmd = [[rg --vimgrep --column --line-number --no-heading --color=always --smart-case --max-columns=4096 \
              --glob '!python*']],
      fzf_opts = {
        ['--history'] = vim.fn.stdpath("data") .. '/fzf-lua-grep-history',
      },
      -- Enable use glob
      -- NOTE: Glob uses for file filter. Need add `--` between `rg' and `glob`
      -- Correct rule ```ripgrep_rules -- glob_rules```. 
      rg_glob = true,
    },
    oldfiles = {
      -- Show only current workspace files
      cwd_only = true,
      include_current_session = true,
    },
    -- TODO: Add detoggle all
    keymap = {
      builtin = {
        ["<c-d>"] = "preview-page-down",
        ["<c-u>"] = "preview-page-up",
        ["<c-y>"] = "preview-down",
        ["<c-e>"] = "preview-up",
      }
    },
  },
  keys = function (PluginSpec)
    local fzf_lua = require('fzf-lua')
    -- Buffers and Files
    vim.keymap.set("n", "<leader>ff", fzf_lua.files, { desc = "Fzf files"})
    vim.keymap.set("n", "<leader>fo", fzf_lua.oldfiles, { desc = "Fzf old files"})
    vim.keymap.set("n", "<leader>fb", fzf_lua.buffers, { desc = "Fzf buffer"})
    vim.keymap.set("n", "<leader>ft", fzf_lua.tabs, { desc = "Fzf tabs"})
    vim.keymap.set("n", "<leader>fl", fzf_lua.lines, { desc = "Fzf buffers lines"})
    -- vim.keymap.set("n", "<leader>fS", fzf_lua.blines, { desc = "Fzf cur buffer lines"})
    vim.keymap.set("n", "<leader>fs", fzf_lua.treesitter, { desc = "Fzf treesitter symbols"})

    -- Search
    vim.keymap.set("n", "<leader>fg", fzf_lua.live_grep, { desc = "Fzf live_grep"})
    -- Resume last search
    vim.keymap.set("n", "<leader>fG", fzf_lua.live_grep_resume, { desc = "Fzf resume live_grep"})

    -- Misc
    vim.keymap.set("n", "<leader>fm", fzf_lua.marks, { desc = "Fzf marks"})
    vim.keymap.set("n", "<leader>fj", fzf_lua.jumps, { desc = "Fzf jumps"})
    vim.keymap.set("n", "<leader>fh", fzf_lua.helptags, { desc = "Fzf helptags"})
    vim.keymap.set("n", "<leader>f:", fzf_lua.command_history, { desc = "Fzf command history"})
    vim.keymap.set("n", "<leader>f/", fzf_lua.search_history, { desc = "Fzf search history"})
    vim.keymap.set("n", "<leader>fc", fzf_lua.changes, { desc = "Fzf last changes"})

    -- NOTE: Todo-comments plugin keybind
    vim.keymap.set("n", "<leader>fd", "<cmd>TodoFzfLua<cr>", { desc = "Fzf todo"})

    -- TODO: check does DAP needed, if so than add

    -- LSP
    -- Declaration and all definitions current variable
    vim.keymap.set("n", "<leader>lr", fzf_lua.lsp_references, { desc = "Fzf lsp references"})
    -- Calls current object exclude initialisation
    vim.keymap.set("n", "<leader>li", fzf_lua.lsp_incoming_calls, { desc = "Fzf lsp incoming calls"})
    -- Callable objects in current object
    vim.keymap.set("n", "<leader>lo", fzf_lua.lsp_outgoing_calls, { desc = "Fzf lsp outcoming calls"})
    -- Symbols
    vim.keymap.set("n", "<leader>ls", fzf_lua.lsp_document_symbols, { desc = "Fzf lsp document symbols"})
    vim.keymap.set("n", "<leader>lS", fzf_lua.lsp_live_workspace_symbols, { desc = "Fzf lsp live workspace symbols"})
    
    -- LSP diagnostic
    -- TODO: add diagnostic all workspace (not only buffer)
    -- Also add file names for errors because hard understand without this + add navigation
    vim.keymap.set("n", "<leader>lx", fzf_lua.diagnostics_workspace, { desc = "Fzf lsp buffer workspace symbols"})
    vim.keymap.set("n", "<leader>lX", fzf_lua.diagnostics_document, { desc = "Fzf lsp buffer document symbols"})

    -- Completion functions
    vim.keymap.set({"i", "n"}, "<a-p>", fzf_lua.complete_path, { desc = "Fzf path completion"})
  end
}
