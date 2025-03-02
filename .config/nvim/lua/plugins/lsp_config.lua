return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "saghen/blink.cmp",
  },

  config = function()
    local capabilities = require 'blink.cmp'.get_lsp_capabilities()
    local lspconfig = require 'lspconfig'

    -- LSP / Liters
    -- Python
    -- TODO: Add environment variable
    -- lspconfig.pyright.setup{ capabilities = capabilities }
    lspconfig.ruff.setup { capabilities = capabilities } -- Linter
    -- C/C++
    lspconfig.clangd.setup { capabilities = capabilities }
    -- CMake
    lspconfig.neocmake.setup { capabilities = capabilities }
    -- Docker
    lspconfig.dockerls.setup { capabilities = capabilities }
    -- Lua
    lspconfig.lua_ls.setup { capabilities = capabilities }
    -- Docker
    lspconfig.dockerls.setup { capabilities = capabilities }
    -- Bash
    lspconfig.bashls.setup { capabilities = capabilities }
    -- Fish
    lspconfig.fish_lsp.setup { capabilities = capabilities }

    -- Diagnostic insert mode
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        -- delay update diagnostics
        update_in_insert = true,
      }
    )

    -- Lsp interaction
    -- NOTE: most lsp keys init into snacks.picker
    vim.api.nvim_create_autocmd("LspAttach", {
      desc = 'LSP actions',
      callback = function(args)
        vim.keymap.set('n', '<leader>lR', "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = 'Rename variable' })
        -- Mostly useless because of write autocmd below
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.format()<cr>', { desc = 'Format current file' })
      end
    })

    -- Add autoformatting on save
    -- Fromatting lsp https://neovim.io/doc/user/lsp.html#vim.lsp.buf.format()
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*", -- Apply to all file types
      callback = function()
        vim.lsp.buf.format({
          async = false, -- Ensure formatting happens before save
          filter = function(client)
            return client.supports_method("textDocument/formatting")
          end
        })
      end
    })

    -- Keybind
    -- Low res window show error
    vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float(0, {scope='line'})<CR>",
      { desc = "Full diagnostic" })
  end,
}
