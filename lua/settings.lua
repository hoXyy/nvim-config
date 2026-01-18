vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('helpers.tabs').setTabs(2)

vim.o.number = true
vim.o.relativenumber = true

vim.o.mouse = 'a'

vim.o.showmode = false

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.o.breakindent = true

vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = 'yes'

vim.o.updatetime = 250

vim.o.timeoutlen = 300

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.cursorline = true

vim.o.scrolloff = 10

vim.o.winborder = 'rounded'

vim.opt.statuscolumn = '%=%{v:lnum} %{v:relnum ? v:relnum : 0}  '

vim.o.confirm = true

vim.o.wrap = false

vim.g.have_nerd_font = true
