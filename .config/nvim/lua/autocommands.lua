-- Autoresize base version
-- TODO: current version is super simple, need upgrade
-- 1. Store window ratio and change it by hands
-- 2. Plot windows according to this ratio (mb add some freeze)
vim.api.nvim_command('autocmd VimResized * wincmd =')

-- Clear nontification results on n-ms leave
vim.api.nvim_create_autocmd("CmdlineLeave", {
  callback = function()
    vim.defer_fn(function()
      vim.cmd("echo ''")
    end, 10000) -- ms
  end
})

-- Autocmds placed somewhere else
-- 1. Add auto fromatting on save into lsp_config.lua
