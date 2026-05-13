return {
  {
    'oribarilan/lensline.nvim',
    branch = 'release/2.x',
    event = 'LspAttach',
    opts = {
      profiles = {
        {
          name = 'profile1',
          providers = {
            { name = 'usages', enabled = true, include = { 'refs' }, breakdown = false },
            { name = 'last_author', enabled = true },
            { name = 'diagnostics', enabled = true },
          },
          style = { render = 'all', placement = 'above' },
        },
      },
    },
  },
}
