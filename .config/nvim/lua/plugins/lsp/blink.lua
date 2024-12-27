return{
  'saghen/blink.cmp',
  -- dependencies = 'rafamadriz/friendly-snippets',
  version = 'v0.*',
  config = function ()
    local has_words_before = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    require("blink.cmp").setup({
      completion = {
        -- Completion read only previous coursor
        keyword = { range = 'prefix' },
        menu = {
          auto_show = true,
        },
      },
      keymap = {
        ['<cr>'] = { 'accept', 'fallback' },
        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
        ['<C-e>'] = { 'show', 'hide', 'fallback' },
        ['<C-space>'] = {'show_documentation', 'hide_documentation', 'fallback'},
        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
      },

      sources = {
        -- Select completion sources according file type or node
        default = function(ctx)
          local success, node = pcall(vim.treesitter.get_node)
          if success and node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
            return { 'buffer' }
          else
            return { 'lsp', 'path', 'snippets', 'buffer' }
          end
        end,

        -- disable cmdline completions
        cmdline = {},
      },

      -- TODO: turn on when test
      -- experimental signature help support
      signature = { enabled = true },

      -- TODO: add jump inside snippets
    })
  end,
  -- allows extending the providers array elsewhere in your config
  -- without having to redefine it
  opts_extend = { "sources.default" },
}
