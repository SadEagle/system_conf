return{
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "onsails/lspkind.nvim",
  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require("luasnip")
    -- Symbols completion items
    local lspkind = require('lspkind')
    -- Add autopairs after completion
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )

    local has_words_before = function()
      -- Check it's buffer
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end
    cmp.setup({
      -- Add custom snippet
      snippet = {
        expand = function(arg)
          luasnip.lsp_expand(arg.body)
        end,
      },
      -- Set completion menu and results close to cursor
      view = {
        entries = {name = 'custom', selection_order = 'near_cursor' },
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = function(fallback)
          if cmp.visible() then
            if #cmp.get_entries() == 1 then
              cmp.confirm({ select = true })
            else
              cmp.select_next_item()
            end
          -- elseif luasnip.lockally_jampable(1) then
          --   luasnip.jump(1)
          elseif has_words_before() then
            cmp.complete()
            if #cmp.get_entries() == 1 then
              cmp.confirm({ select = true })
            end
          else
            fallback()
          end
        end,
        ['<S-Tab>'] = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          -- elseif luasnip.locally_jumpable(1) then
          --   luasnip.jump(1)
          else
            fallback()
          end
        end,
        -- TODO: if not select any variant - <cr> go to new line (not hide menu)
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-e>'] = cmp.mapping.abort(),
      }),

      -- TODO: what is it (buffer)
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
      }, {
          { name = 'buffer' },
        }),

      enabled = function()
        -- Disable in Telescope, needs because has_words_before() breaks cmp check
        local buftype = vim.api.nvim_buf_get_option(0, "buftype")
        if buftype == "prompt" then return false end

        -- Disable completion in comments
        local context = require('cmp.config.context')
        -- keep command mode completion enabled when cursor is in a comment
        if vim.api.nvim_get_mode().mode == 'c' then
          return true
        else
          return not context.in_treesitter_capture("comment") 
            and not context.in_syntax_group("Comment")
        end
      end,

      -- Add type icons
      formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol', -- show only symbol annotations
          maxwidth = {
            -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            menu = 50, -- leading text (labelDetails)
            abbr = 50, -- actual suggestion item
          },
          ellipsis_char = '...', -- when popup menu exceed maxwidth, truncate other part
          show_labelDetails = true, -- show labelDetails in menu. Disabled by default
        })
      }
    })

  end
}
