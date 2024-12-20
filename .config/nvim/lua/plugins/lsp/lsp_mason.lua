return{
  "neovim/nvim-lspconfig",
  dependencies = {
    "saghen/blink.cmp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  build = ":MasonUpdate",
  -- Fast enough
  -- event = { "BufReadPre", "BufNewFile" },

  config = function()
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    local lspconfig = require('lspconfig')

    require("mason").setup{
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    }
    require("mason-lspconfig").setup{
      automatic_installation = true,
      ensure_installed = {
        "clangd",
        "lua_ls",
        "pyright",
        "cmake",
      },
    }
    require("mason-lspconfig").setup_handlers {
      function (server_name) -- default handler
        require("lspconfig")[server_name].setup({ capabilities = capabilities })
      end,
    }

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
    vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float(0, {scope='line'})<CR>", {desc = "Show full diagnostic line"})
    -- FIX: off twice press - jump in hover menu
    vim.keymap.set('n', 'K', "<cmd>lua vim.lsp.buf.hover()<cr>", { desc = 'Lsp jump to definition' })

    -- Lsp interaction
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function (args)
        -- TODO: add check before add command
        -- https://neovim.io/doc/user/lsp.html#lsp-attach
        -- local client = vim.lsp.get_client_by_id()
        vim.keymap.set('n', '<leader>gd', "<cmd>lua vim.lsp.buf.definition()<cr>", { desc = 'Lsp jump to definition' })
        vim.keymap.set('n', '<leader>gD', "<cmd>lua vim.lsp.buf.declaration()<cr>", { desc = 'Lsp jump to declaration' })
        vim.keymap.set('n', '<leader>gr', "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = 'Lsp rename variable' })

        vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { desc =  "Go to previous diagnostic" })
        vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>",  { desc = "Go to next diagnostic" })

      end
    })
  end,
}
