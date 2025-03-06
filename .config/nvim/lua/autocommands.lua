-- Autoresize base version
-- TODO: current version is super simple, need upgrade
-- 1. Add resizing terminal
-- 2. Store window ratio and change it by hands
-- 3. Plot windows according to this ratio (mb add some freeze)
vim.api.nvim_command('autocmd VimResized * wincmd =')

-- Clear nontification results on n-ms leave
vim.api.nvim_create_autocmd("CmdlineLeave", {
  callback = function()
    vim.defer_fn(function()
      vim.cmd("echo ''")
    end, 10000) -- ms
  end
})

-- Add auto fromatting on save into lsp_config.lua
