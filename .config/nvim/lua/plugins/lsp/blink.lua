return{
  'saghen/blink.cmp',
  -- dependencies = 'rafamadriz/friendly-snippets',
  version = 'v0.*',
  opts = {
    keymap = {
      ['<cr>'] = { 'accept', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'fallback' },
      -- TODO: add cmp-nvim completion for tab, add tabulation if line empty
      -- ['<Tab>'] = {
      --   function (cmp)
      --     if cmp.visible() then
      --       if #cmp.get_entries() == 1 then
      --         cmp.confirm({ select = true })
      --       else
      --         cmp.select_next_item()
      --       end
      --       -- elseif luasnip.lockally_jampable(1) then
      --       --   luasnip.jump(1)
      --     elseif has_words_before() then
      --       cmp.complete()
      --       if #cmp.get_entries() == 1 then
      --         cmp.confirm({ select = true })
      --       end
      --     else
      --       fallback()
      --     end
      --   end
      -- },
      ['<Tab>'] = { 'show', 'select_next', 'fallback' },
      ['<C-e>'] = { 'hide', 'fallback' },
      ['<C-space>'] = {'show_documentation', 'hide_documentation' },
      -- ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      -- ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      -- optionally disable cmdline completions
      -- cmdline = {},
    },

    -- experimental signature help support
    -- signature = { enabled = true },
  },
  -- allows extending the providers array elsewhere in your config
  -- without having to redefine it
  opts_extend = { "sources.default" },
}
