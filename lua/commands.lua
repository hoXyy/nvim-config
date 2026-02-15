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
  local isNodeProject = require('helpers.npm-helpers').isNodeProject()
  if not isNodeProject then
    vim.notify('Not in Node.js project, aborting...', vim.log.levels.WARN)
    return
  end

  local packageManager = require('helpers.npm-helpers').detectPackageManager()
  local install_cmd = {
    npm = 'npm install',
    yarn = 'yarn install',
    pnpm = 'pnpm install',
    bun = 'bun install',
  }
  vim.cmd('!' .. install_cmd[packageManager])
end, { desc = 'install npm dependencies, with automatic package manager detection' })
