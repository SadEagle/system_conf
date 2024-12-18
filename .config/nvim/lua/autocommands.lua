-- NOTE: save file every insert and change. Fzf-lua workaround
-- fzf-lua works only with saved version of the file
vim.api.nvim_create_autocmd({"InsertLeave", "TextChanged"}, {
  pattern = "*",
  command = "silent! update",
})
