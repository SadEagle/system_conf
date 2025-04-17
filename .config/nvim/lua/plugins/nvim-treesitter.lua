return {
  {
    "nvim-treesitter/nvim-treesitter",
    main = "nvim-treesitter.configs",
    build = ":TSUpdate",
    -- https://github.com/folke/lazy.nvim/discussions/889
    event = { "BufReadPre", "BufNewFile" },
    init = function()
      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

      vim.filetype.add({
        pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
      })
    end,
    opts = {
      ensure_installed = {
        "bash",
        "fish",
        "lua",
        "rust",
        "zig",
        "python",
        "c",
        "cpp",
        "make",
        "cmake",
        "markdown",
        "markdown_inline",
        "sql",
        "yaml",
        "dockerfile",
        "hyprlang",
        "gitignore",
        "gitcommit",
        "git_rebase",
        "git_config",
        "gitattributes",
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
        disable = { "python", },
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
  },

  -- Treesitter indentation fix
  -- Python
  { "Vimjas/vim-python-pep8-indent" },
}
