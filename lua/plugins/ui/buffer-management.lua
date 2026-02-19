return {
  {
    'akinsho/bufferline.nvim',
    config = function()
      require('bufferline').setup {
        options = {
          style_preset = require('bufferline').style_preset.no_italic,
          truncate_names = false,
          offsets = {
            {
              filetype = 'NvimTree',
              separator = true,
            },
          },
        },
      }
    end,
    lazy = false,
    version = '*',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    keys = {
      {
        '[b',
        '<cmd>BufferLineCyclePrev<CR>',
        mode = 'n',
        desc = 'Previous buffer',
      },
      {
        ']b',
        '<cmd>BufferLineCycleNext<CR>',
        mode = 'n',
        desc = 'Next buffer',
      },
      -- {
      --   '<leader>bc',
      --   '<cmd>BufferClose<CR>',
      --   mode = 'n',
      --   desc = 'Close buffer',
      -- },
      {
        '<leader>bp',
        '<cmd>BufferLineTogglePin<CR>',
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
