return {
  {
    'catppuccin/nvim',
    priority = 1000,
    name = 'catppuccin',
    lazy = false,
    config = function()
      require('catppuccin').setup {
        flavour = 'mocha',
        no_italic = true,
        dim_inactive = {
          enabled = true,
        },
        auto_integrations = true,
      }

      vim.cmd.colorscheme 'catppuccin-nvim'
    end,
  },
}
