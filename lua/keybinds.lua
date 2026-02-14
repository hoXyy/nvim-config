local map = require('helpers.keymap').map

-- Splits

-- Movement between splits
map('<C-h>', '<C-w><C-h>', 'Move focus to the left window')
map('<C-l>', '<C-w><C-l>', 'Move focus to the right window')
map('<C-j>', '<C-w><C-j>', 'Move focus to the lower window')
map('<C-k>', '<C-w><C-k>', 'Move focus to the upper window')

-- Making splits
vim.keymap.set('n', '<leader>|', '<C-W>s', { desc = 'Split window below', remap = true })
vim.keymap.set('n', '<leader>-', '<C-W>v', { desc = 'Split window right', remap = true })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map('<Esc>', '<cmd>nohlsearch<CR>')

-- Keybind to exit terminal mode
map('<Esc><Esc>', '<C-\\><C-n>', 'Exit terminal mode', 't')

-- Trouble.nvim keybinds
map('<leader>td', function()
  require('trouble').toggle 'diagnostics'
end, '[T]oggle [D]iagnostics with Trouble.nvim')

map('<leader>ts', function()
  require('trouble').toggle 'lsp_document_symbols'
end, '[T]oggle Document [S]ymbols with Trouble.nvim')

-- LSP related keybinds, created after a LSP is attached
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = false }),
  callback = function(event)
    -- Open diagnostics float
    map('<leader>D', vim.diagnostic.open_float, 'Show floating diagnostics window on current line')

    -- Toggle inlay hints
    map('<leader>th', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
    end, 'LSP: [T]oggle Inlay [H]ints')

    -- Rename the variable under the cursor.
    map('grn', vim.lsp.buf.rename, 'LSP: [R]e[n]ame')

    -- Execute a code action
    map('gra', vim.lsp.buf.code_action, 'LSP: [G]oto Code [A]ction', { 'n', 'x' })

    -- Find references
    map('grr', function()
      Snacks.picker.lsp_references()
    end, 'LSP: [G]oto [R]eferences')

    -- Find implementations
    map('grr', function()
      Snacks.picker.lsp_implementations()
    end, 'LSP: [G]oto [I]mplementation')

    -- Go to definition
    map('grd', vim.lsp.buf.definition, 'LSP: [G]oto [D]efinition')

    -- Go to declaration
    map('grD', vim.lsp.buf.declaration, 'LSP: [G]oto [D]eclaration')

    -- Go to type definition
    map('grt', vim.lsp.buf.type_definition, 'LSP: [G]oto [T]ype Definition')

    -- Hover
    map('K', function()
      vim.lsp.buf.hover()
    end, 'Pretty Hover')
  end,
})
