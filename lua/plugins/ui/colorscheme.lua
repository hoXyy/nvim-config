return {
  {
    'folke/tokyonight.nvim',
    priority = 100,
    lazy = false,
    config = function()
      vim.cmd.colorscheme 'tokyonight'
    end,
  },
}
