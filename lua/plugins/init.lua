-- Add plugins and set up colorscheme as the first thing
vim.pack.add {
  'https://github.com/vague-theme/vague.nvim',
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
  'https://github.com/folke/snacks.nvim',
  'https://github.com/nvim-mini/mini.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-tree/nvim-tree.lua',
  'https://github.com/igorlfs/nvim-lsp-file-operations',
  'https://github.com/onsails/lspkind.nvim',
  'https://github.com/folke/trouble.nvim',
  'https://github.com/folke/todo-comments.nvim',
  { src = 'https://github.com/saghen/blink.cmp', version = 'v1.8.0' },
  'https://github.com/numToStr/Comment.nvim',
  { src = 'https://github.com/kylechui/nvim-surround', version = 'v3.1.8' },
  'https://github.com/romgrk/barbar.nvim',
  'https://github.com/Bekaboo/dropbar.nvim',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/antoinemadec/FixCursorHold.nvim',
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/nvim-neotest/neotest',
  'https://github.com/nvim-neotest/neotest-jest',
  'https://github.com/marilari88/neotest-vitest',
}

require('vague').setup {
  italic = false,
}
vim.cmd.colorscheme 'vague'

require 'plugins.ui'
require 'plugins.languages'
