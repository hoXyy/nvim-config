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

  Snacks.terminal.open(install_cmd[packageManager], {
    win = {
      style = 'terminal',
    },
    auto_close = false,
  })
end, { desc = 'install npm dependencies, with automatic package manager detection' })

-- npm test, with automatic package manager detection
vim.api.nvim_create_user_command('NpmTest', function()
  local isNodeProject = require('helpers.npm-helpers').isNodeProject()
  if not isNodeProject then
    vim.notify('Not in Node.js project, aborting...', vim.log.levels.WARN)
    return
  end

  local packageManager = require('helpers.npm-helpers').detectPackageManager()
  local test_cmd = {
    npm = 'npm test',
    yarn = 'yarn test',
    pnpm = 'pnpm test',
    bun = 'bun test',
  }

  Snacks.terminal.open(test_cmd[packageManager], {
    win = {
      style = 'terminal',
    },
    auto_close = false,
  })
end, { desc = 'run npm tests, with automatic package manager detection' })
