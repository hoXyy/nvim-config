-- Colorize HEX colors
require('mini.hipatterns').setup { highlighters = { hex_color = require('mini.hipatterns').gen_highlighter.hex_color() } }

-- Better Around/Inside textobjects
--
-- Examples:
--  - va)  - [V]isually select [A]round [)]paren
--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
--  - ci'  - [C]hange [I]nside [']quote
require('mini.ai').setup {
  n_lines = 500,
}

-- Add/delete/replace surroundings (brackets, quotes, etc.)
--
-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
-- - sd'   - [S]urround [D]elete [']quotes
-- - sr)'  - [S]urround [R]eplace [)] [']
require('mini.surround').setup()

-- Autopairs
require('mini.pairs').setup()

-- Git diff
require('mini.diff').setup()
