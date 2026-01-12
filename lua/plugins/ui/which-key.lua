require('which-key').setup {
  delay = 0,
  icons = {
    mappings = true,
    keys = {},
  },
  spec = {
    { '<leader>s', group = '[S]earch' },
    { '<leader>t', group = '[T]oggle' },
  },
}
