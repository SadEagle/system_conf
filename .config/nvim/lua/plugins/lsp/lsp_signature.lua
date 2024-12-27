return{
  "ray-x/lsp_signature.nvim",
  cond = false,
  event = "InsertEnter",
  main = "lsp_signature",
  opts = {
    hint_prefix = "⚙ ",
  },
  -- TODO: fix:
  -- 1. python Unknow -> Any
  -- 2. highlight Any
  -- 3. change param by name or so, now expect only 
  -- 4. mixing position with error line
  keys = function(PluginSpec)
    local lsp_sign = require(PluginSpec.main)

    -- Toggle current signature
    vim.keymap.set({ 'i' }, '<C-s>', function() lsp_sign.toggle_float_win()
    end, { silent = true, noremap = true, desc = 'Toggle signature' })

  end
}
