return {
  {
    'AvengeMedia/base46',
    priority = 1000,
    lazy = false,
    config = function()
      require('base46').setup {}

      vim.cmd.colorscheme 'base46-catppuccin'
    end,
  },
}
