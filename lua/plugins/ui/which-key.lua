return {
  {
    'folke/which-key.nvim',
    cmd = 'WhichKey',
    event = 'VimEnter',
    opts = {
      delay = 0,
      icons = {
        mappings = true,
        keys = {},
      },
      spec = {
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>n', group = '[N]PM' },
        { '<leader>b', group = '[B]uffer' },
      },
    },
    tag = 'v3.17.0',
  },
}
