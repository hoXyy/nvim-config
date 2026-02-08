require('guess-indent').setup {}
require('nvim-ts-autotag').setup()

-- conform.nvim settings
require('conform').setup {
  formatters_by_ft = {
    lua = { 'stylua' },
    nix = { 'alejandra' },
  },
  notify_on_error = false,
  format_on_save = function(bufnr)
    local disable_filetypes = { c = true, cpp = true }
    if disable_filetypes[vim.bo[bufnr].filetype] then
      return nil
    else
      return {
        timeout_ms = 500,
        lsp_format = 'fallback',
      }
    end
  end,
}

vim.keymap.set('n', '<leader>f', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
end, { desc = '[F]ormat buffer with conform.nvim' })
