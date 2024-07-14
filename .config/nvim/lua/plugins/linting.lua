return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      -- Need luarock for lua linter
      -- lua = { "stylua" },
      cpp = { "cpplint"},
      python = { "pylint" },
      markdown = { "markdownlint"},
      yaml = { "yamllint" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>li", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
