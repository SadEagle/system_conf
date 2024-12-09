return{
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  build = ":MasonUpdate",
  -- Fast enough
  -- event = { "BufReadPre", "BufNewFile" },

  config = function()
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
        require("lspconfig")[server_name].setup{}
      end,
    }
  end
}
