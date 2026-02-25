return {
  {
    'catppuccin/nvim',
    priority = 100,
    name = 'catppuccin',
    lazy = false,
    config = function()
      require('catppuccin').setup {
        no_italic = true,
      }

      vim.cmd.colorscheme 'catppuccin'
    end,
  },
  {
    'HiPhish/rainbow-delimiters.nvim',
  },
}
