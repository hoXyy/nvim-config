local vscode = require 'vscode'

vim.keymap.set('n', '<leader>sf', function()
  vscode.action 'workbench.action.quickOpen'
end, { desc = 'Show Quick Open dropdown menu' })

vim.keymap.set('n', '<leader>f', function()
  vscode.action 'editor.action.formatDocument'
end, { desc = 'Format Document' })

vim.keymap.set('n', '<leader>lg', function()
  vscode.action 'lazygit.openLazygit'
end)
