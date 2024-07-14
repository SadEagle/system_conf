return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      ensure_installed = {
        "lua_ls",
        "clangd",
        "pyright",
      },
      -- auto installation
      automatic_installation = true,
    })

    mason_tool_installer.setup({
      ensure_installed = {
        -- -- Linters
        -- "luacheck",
        "cpplint",
        "pylint",
        "markdownlint",
        "yamllint"
        
        -- -- Formatters
        -- "prettier", -- prettier formatter
        -- "stylua", -- lua formatter
        -- "isort", -- python formatter
      },
      auto_update = true,
      run_on_start = true,
      start_delay = 3000, -- 3 second delay
      debounce_hours = 5, -- at least 5 hours between attempts to install/update
    })
  end,
}
