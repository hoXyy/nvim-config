return {
  {
    'navarasu/onedark.nvim',
    priority = 100,
    name = 'onedark',
    lazy = false,
    config = function()
      require('onedark').setup {
        style = 'dark',
        diagnostics = {
          darker = false,
        },
      }

      require('onedark').load()
    end,
  },
  {
    'HiPhish/rainbow-delimiters.nvim',
  },
}
