vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.o.signcolumn = 'yes'
vim.opt.expandtab = true
vim.cmd [[highlight! link signcolumn normal]]
vim.api.nvim_set_hl(0, "statusline", { link = "normal" })
vim.api.nvim_set_hl(0, "statuslinenc", { link = "normal" })
vim.api.nvim_set_hl(0, "msgarea", { link = "normal" })
vim.opt.clipboard = "unnamedplus"
vim.opt.linebreak = false
vim.opt.wrap = true
vim.opt.mouse = 'a'
vim.opt.autoindent = true
vim.opt.cursorline = true
vim.opt.cmdheight = 1
vim.opt.breakindent = false
vim.opt.scrolloff = 4

vim.g.mapleader = " "
