return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function(_, _)
    vim.cmd[[colorscheme tokyonight-night]]
  end
}
