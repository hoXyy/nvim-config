return {
  {
    'vague-theme/vague.nvim',
    priority = 100,
    lazy = false,
    name = 'vague',
    config = function()
      require('vague').setup {
        italic = false,
      }
      vim.cmd.colorscheme 'vague'
    end,
  },
}
