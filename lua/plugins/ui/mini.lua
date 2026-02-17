return {
  -- Colorize HEX colors
  {
    'nvim-mini/mini.hipatterns',
    event = 'BufEnter',
    config = function()
      require('mini.hipatterns').setup {
        hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
      }
    end,
  },
  -- Better Around/Inside textobjects
  --
  -- Examples:
  --  - va)  - [V]isually select [A]round [)]paren
  --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
  --  - ci'  - [C]hange [I]nside [']quote
  {
    'nvim-mini/mini.ai',
    lazy = false,
    opts = {
      n_lines = 500,
    },
  },
  -- Move selections
  {
    'nvim-mini/mini.move',
    event = 'BufEnter',
    opts = {},
  },
}
