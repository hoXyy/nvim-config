-- Add plugins and set up colorscheme as the first thing
vim.pack.add {
  'https://github.com/rmehri01/onenord.nvim',
  'https://github.com/windwp/nvim-ts-autotag',
  { src = 'https://github.com/nvim-lualine/lualine.nvim', name = 'lualine' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },
  { src = 'https://github.com/folke/which-key.nvim', version = 'v3.17.0' },
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/NMAC427/guess-indent.nvim',
  'https://github.com/j-hui/fidget.nvim',
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/folke/lazydev.nvim',
  'https://github.com/lukas-reineke/indent-blankline.nvim',
  'https://github.com/serhez/bento.nvim',
  'https://github.com/folke/snacks.nvim',
  'https://github.com/nvim-mini/mini.nvim',
  'https://github.com/hrsh7th/nvim-cmp',
}

require('onenord').setup {
  theme = 'dark',
  styles = {
    comments = 'italic',
    functions = 'bold',
  },
}

vim.cmd.colorscheme 'onenord'

require 'plugins.ui'
require 'plugins.languages'
