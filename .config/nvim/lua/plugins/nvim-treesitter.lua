return{
  {
    "nvim-treesitter/nvim-treesitter",
    main = "nvim-treesitter.configs",
    build = ":TSUpdate",
    -- https://github.com/folke/lazy.nvim/discussions/889
    event = { "BufReadPre", "BufNewFile" },
    opts={
      ensure_installed= {
        "bash",
        "fish",
        "lua",
        "python",
        "c",
        "cpp",
        "make",
        "cmake",
        "sql",
        "yaml",
        "dockerfile",
        "gitignore",
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
        disable = {"python",},
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<a-,>", 
          node_incremental = "<a-m>",
          scope_incremental = "<a-,>",
          node_decremental = "<a-.>",
        }
      },
    },
    config = function(PluginSpec)
      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      require(PluginSpec.main).setup(PluginSpec.opts)
    end
  },

  -- Treesitter indentation fix
  -- Python 
  {"Vimjas/vim-python-pep8-indent"},
}
