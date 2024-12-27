vim.g.mapleader = " "

local map = vim.keymap.set

-- Switch windows
map("n", "<C-h>", "<C-w>h", { desc = "Switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "Switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "Switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Switch window up" })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Clear highlight
map("n", "<a-n>", ":nohl<CR>", { desc = "Clear search highlights", silent = true })

-- Comment
map("n", "<leader>/", "gcc", { desc = "Comment toggle", remap = true })
map("v", "<leader>/", "gc", { desc = "Comment toggle", remap = true })

-- Reverse tab
map('i', '<S-Tab>', '<C-D>', { desc = "Reverse tab", remap = true })

-- Next snippet
vim.keymap.set({ 'i', 's' }, '<Tab>', function()
   if vim.snippet.active({ direction = 1 }) then
     return '<Cmd>lua vim.snippet.jump(1)<CR>'
   else
     return '<Tab>'
   end
 end, { expr = true })

-- -- Tabs management
-- map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
-- map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
-- map("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
-- map("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
-- map("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
 
-- Split tab and C-i signals by setting both (more info :h C-i)
map("n", "<C-i>", "<C-i>")
-- Work with buffer
map("n", "<tab>", "<cmd>bnext<CR>", { desc = "Buffer goto next" })
map("n", "<S-Tab>", "<cmd>bprev<CR>", { desc = "Buffer goto prev" })

-- Working with bufer 
-- map("n", "<leader>x", "<cmd>bp<bar>sp<bar>bn<bar>bd!<CR>", { desc = "Buffer close without window"})
-- map("n", "<leader>q", "<cmd>bd<bar>bn<CR>", { desc = "Buffer close without window"})
-- map("n", "<leader>x",  "<cmd>bd<CR>", { desc = "Buffer close with window" })
-- terminal
-- map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

