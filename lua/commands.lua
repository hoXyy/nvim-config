-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Update plugins
vim.api.nvim_create_user_command('PackUpdate', function()
  vim.pack.update()
end, {})

-- npm install, with automatic package manager detection
vim.api.nvim_create_user_command('NpmInstall', function()
  local packageManager = require('helpers.node-package-manager-detect').detectPackageManager()
end, { desc = 'install npm dependencies, with automatic package manager detection' })
