return {
  {
    'romgrk/barbar.nvim',
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {},
    lazy = false,
    keys = {
      {
        '[b',
        '<cmd>BufferPrevious<CR>',
        mode = 'n',
        desc = 'Previous buffer',
      },
      {
        ']b',
        '<cmd>BufferNext<CR>',
        mode = 'n',
        desc = 'Next buffer',
      },
      {
        '<leader>bc',
        '<cmd>BufferClose<CR>',
        mode = 'n',
        desc = 'Close buffer',
      },
      {
        '<leader>bp',
        '<cmd>BufferPin<CR>',
        mode = 'n',
        desc = 'Pin buffer',
      },
    },
  },
  {
    'Bekaboo/dropbar.nvim',
    opts = {},
    lazy = false,
  },
}
