return {
  {
    'folke/trouble.nvim',
    opts = {},
    keys = {
      {
        '<leader>td',
        function()
          require('trouble').toggle 'diagnostics'
        end,
        mode = 'n',
        desc = '[T]oggle [D]iagnostics with Trouble.nvim',
      },
      {
        '<leader>ts',
        function()
          require('trouble').toggle 'lsp_document_symbols'
        end,
        mode = 'n',
        desc = '[T]oggle Document [S]ymbols with Trouble.nvim',
      },
    },
  },
}
