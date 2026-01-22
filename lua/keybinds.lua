local vscode = require 'vscode'

vim.keymap.set('n', '<leader>sf', function()
  vscode.action 'workbench.action.quickOpen'
end, { desc = 'Show Quick Open dropdown menu' })

vim.keymap.set('n', '<leader>f', function()
  vscode.action 'editor.action.formatDocument'
end, { desc = 'Format Document' })

vim.keymap.set('n', '<leader>lg', function()
  vscode.action 'lazygit.openLazygit'
end, { desc = 'Open Lazygit' })

vim.keymap.set('n', '<leader>e', function()
  vscode.action 'workbench.action.toggleSidebarVisibility'
end, { desc = 'Toggle Sidebar' })

vim.keymap.set('n', 'grd', function()
  vscode.action 'editor.action.revealDefinition'
end, { desc = 'Go to definition' })

vim.keymap.set('n', 'grD', function()
  vscode.action 'editor.action.revealDeclaration'
end, { desc = 'Go to declaration' })

vim.keymap.set('n', 'grr', function()
  vscode.action 'editor.action.goToReferences'
end, { desc = 'Go to references' })

vim.keymap.set('n', 'grn', function()
  vscode.action 'editor.action.rename'
end, { desc = 'Rename symbol' })

vim.keymap.set('n', 'grt', function()
  vscode.action 'editor.action.goToTypeDefinition'
end, { desc = 'Go to type definition' })

vim.keymap.set('n', '<leader>th', function()
  local inlayHintsStatus = vscode.get_config 'editor.inlayHints.enabled'

  if inlayHintsStatus == 'on' then
    vscode.update_config('editor.inlayHints.enabled', 'off', 'global')
  else
    vscode.update_config('editor.inlayHints.enabled', 'on', 'global')
  end
end, { desc = 'Toggle Inlay Hints' })

vim.keymap.set('n', '<leader>tp', function()
  vscode.action 'workbench.actions.view.problems'
end, { desc = 'Toggle problems panel' })

vim.keymap.set('n', 'gO', function()
  vscode.action 'workbench.action.gotoSymbol'
end, { desc = 'Open Document Symbols' })

vim.keymap.set('n', 'gW', function()
  vscode.action 'workbench.action.showAllSymbols'
end, { desc = 'Open Workspace Symbols' })
