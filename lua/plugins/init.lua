-- Add plugins and set up colorscheme as the first thing
vim.pack.add {
  {
    src = 'https://github.com/catppuccin/nvim',
    name = 'catppuccin',
  },
  'https://github.com/windwp/nvim-ts-autotag',
  { src = 'https://github.com/nvim-lualine/lualine.nvim', name = 'lualine' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },
  { src = 'https://github.com/folke/which-key.nvim', version = 'v3.17.0' },
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/NMAC427/guess-indent.nvim',
}

require('catppuccin').setup {
  flavor = 'macchiato',
}

vim.cmd.colorscheme 'catppuccin'

require 'plugins.ui'
require 'plugins.languages'
