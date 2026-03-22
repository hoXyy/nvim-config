return {
  {
    'saghen/blink.pairs',
    version = '*',
    dependencies = { 'saghen/blink.download' },
    --- @module 'blink.pairs'
    --- @type blink.pairs.Config
    opts = {
      highlights = {
        matchparen = {
          include_surrounding = true,
        },
      },
    },
  },
}
