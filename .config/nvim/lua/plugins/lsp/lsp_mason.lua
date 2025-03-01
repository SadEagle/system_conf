-- TODO: fix troublesome Keybinds
-- LSP part of keybinds in snacks.nvim
return{
  "neovim/nvim-lspconfig",
  dependencies = {
    "saghen/blink.cmp",
  },

  config = function()
    local capabilities = require'blink.cmp'.get_lsp_capabilities()
    local lspconfig = require'lspconfig'

    -- LSP / Liters
    -- Python
    -- TODO: Add environment variable
    lspconfig.pyright.setup{ capabilities = capabilities }
    lspconfig.ruff.setup{ capabilities = capabilities } -- Linter
    -- C/C++
    lspconfig.clangd.setup{ capabilities = capabilities }
    -- CMake
    lspconfig.neocmake.setup{ capabilities = capabilities }
    -- Docker
    lspconfig.dockerls.setup{ capabilities = capabilities }
    -- Lua
    lspconfig.lua_ls.setup{ capabilities = capabilities }
    -- Docker
    lspconfig.dockerls.setup{ capabilities = capabilities }
    -- Bash
    lspconfig.bashls.setup{ capabilities = capabilities }
    -- Fish
    lspconfig.fish_lsp.setup{ capabilities = capabilities }

    -- Diagnostic insert mode
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        -- delay update diagnostics
        update_in_insert = true,
      }
    )

    -- TODO: change insert mode cursor line errors, may be dont show warnings while working? Annoying

    -- Keybinds
    -- Low res window show error
    vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float(0, {scope='line'})<CR>", {desc = "Full diagnostic"})
    -- TODO: change way to memorize default keybinds
    -- vim.keymap.set('n', 'K', "<cmd>lua vim.lsp.buf.hover()<cr>", { desc = 'Show definition' })
    -- vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { desc =  "Go to previous diagnostic" })
    -- vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>",  { desc = "Go to next diagnostic" })

    -- Lsp interaction
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function (args)
        vim.keymap.set('n', '<leader>lR', "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = 'Rename variable' })
        -- TODO: recheck what commands need to add
        -- https://neovim.io/doc/user/lsp.html#lsp-attach
        -- local client = vim.lsp.get_client_by_id()
        -- vim.keymap.set('n', '<leader>gd', "<cmd>lua vim.lsp.buf.definition()<cr>", { desc = 'Lsp jump to definition' })
        -- vim.keymap.set('n', '<leader>gD', "<cmd>lua vim.lsp.buf.declaration()<cr>", { desc = 'Lsp jump to declaration' })
      end
    })
  end,
}
