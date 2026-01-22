vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.mouse = 'a'

vim.o.breakindent = true

vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.updatetime = 250

vim.o.timeoutlen = 300

vim.o.inccommand = 'split'

vim.o.scrolloff = 10

vim.o.confirm = true

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- all this stuff is just so the mode is always shown in the statusline

local mode_names = {
  n = 'NORMAL',
  no = 'OPERATOR PENDING',
  i = 'INSERT',
  ic = 'INSERT',
  ix = 'INSERT',
  v = 'VISUAL',
  V = 'VISUAL LINE',
  ['\22'] = 'VISUAL BLOCK', -- Ctrl-V
  R = 'REPLACE',
  Rc = 'REPLACE',
  Rv = 'V-REPLACE',
  c = 'COMMAND',
  s = 'SELECT',
  S = 'SELECT LINE',
  ['\19'] = 'SELECT BLOCK',
  t = 'TERMINAL',
}

function _G.vim_showmode()
  local mode = vim.fn.mode(1)
  local name = mode_names[mode] or mode

  if vim.fn.getcmdtype() ~= '' then
    return ''
  end

  return string.format('-- %s --', name)
end

vim.opt.laststatus = 3
vim.opt.showmode = false
vim.opt.showcmd = true
vim.opt.statusline = '%{%v:lua.vim_showmode()%} '

vim.api.nvim_create_autocmd({
  'ModeChanged',
  'CmdlineEnter',
  'CmdlineLeave',
}, {
  callback = function()
    vim.cmd 'redrawstatus'
  end,
})
