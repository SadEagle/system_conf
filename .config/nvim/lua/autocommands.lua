-- NOTE: save file every insert and change. Fzf-lua workaround
-- fzf-lua works only with saved version of the file
vim.api.nvim_create_autocmd({"InsertLeave", "TextChanged"}, {
  pattern = "*",
  command = "silent! update",
})

-- Autoresize base version
-- TODO: current version is super simple, need upgrade
-- 1. Add resizing terminal
-- 2. Store window ratio and change it by hands
-- 3. Plot windows according to this ratio (mb add some freeze)
vim.api.nvim_command('autocmd VimResized * wincmd =')
