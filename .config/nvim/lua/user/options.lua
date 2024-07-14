local opt = vim.opt

-- Colorscheme (correlate with theme)
opt.bg = "dark"

opt.tabstop = 4 -- tab equal 4 spaces
opt.shiftwidth = 4 -- <<, >> symbols amount spaces
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy intend current line for next

--[[
-- Hybrid number settings
opt.number = true
opt.relativenumber = true
--]]

-- Set numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Search
opt.hlsearch = true -- hl search result
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- automatically became case-sensetive when exist both upper and lower cases

opt.scrolloff = 8 -- amount rows before cursor
opt.wrap = false -- words are not split if more than expected
-- opt.whichwrap:=<,>,h,l,[,] -- go next line at the end current (default can't)

-- cursor
-- opt.cursorline = true -- highlihg cursor line

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append({"unnamedplus"}) -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- Statusline
opt.laststatus = 3 -- which windows has statusline (2 - all; 3 - only last)
