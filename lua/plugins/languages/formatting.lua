require('guess-indent').setup {}
require('nvim-ts-autotag').setup()

-- conform.nvim settings
local conform = require 'conform'

conform.setup {
  formatters_by_ft = {
    lua = { 'stylua' },
  },
}

vim.keymap.set('n', '<leader>f', function()
  conform.format { async = true, lsp_format = 'fallback' }
end, { desc = '[F]ormat buffer with conform.nvim' })
