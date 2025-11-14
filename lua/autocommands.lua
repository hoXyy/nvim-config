-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Set Ansible filetype correctly
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { 'playbook*.yml', '*/playbooks/*.yml', '*/roles/*/tasks/*.yml', '*/roles/*/handlers/*.yml' },
  callback = function()
    vim.bo.filetype = 'yaml.ansible'
  end,
})
