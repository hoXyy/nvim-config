return {
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufEnter',
    main = 'ibl',
    opts = {
      exclude = { filetypes = { 'checkhealth' } },
      indent = { char = '▏' },
    },
  },
}
