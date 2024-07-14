return{
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
  },
  config = function()
    local opt = vim.opt
    opt.foldcolumn = '1' -- '0' is not bad
    opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    opt.foldlevelstart = 99
    -- opt.foldmethod = "expr"
    opt.foldenable = true

    vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

    vim.opt.fillchars = {
    --   fold = " ",
    --   eob = " ", -- suppress ~ at EndOfBuffer
      foldopen = "▾",
      -- foldsep = "│",
      foldsep = " ",
      foldclose = "▸",
    }

    -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)


    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities.textDocument.foldingRange = {
    --   dynamicRegistration = false,
    --   lineFoldingOnly = true
    -- }
    -- local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
    -- for _, ls in ipairs(language_servers) do
    --   require('lspconfig')[ls].setup({
    --     capabilities = capabilities
    --     -- you can add other fields for setting up lsp server in this table
    --   })
    -- end
    -- require('ufo').setup()


    local ufo = require('ufo')
    ufo.setup({
      provider_selector = function(bufnr, filetype, buftype)
        return {'treesitter', 'indent'}
      end
    })
  end,
}
