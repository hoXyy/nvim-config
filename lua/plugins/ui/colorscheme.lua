return {
  {
    'folke/tokyonight.nvim',
    priority = 100,
    lazy = false,
    config = function()
      require('tokyonight').setup {
        style = 'storm',
        styles = {
          comments = { italic = false },
          functions = { italic = false },
          keywords = { italic = false },
        },
        lualine_bold = true,
      }

      vim.cmd.colorscheme 'tokyonight'
    end,
  },
}
