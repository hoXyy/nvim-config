local map = function(keys, func, desc, mode)
  mode = mode or 'n'
  vim.keymap.set(mode, keys, func, { desc = 'Picker: ' .. desc })
end

return {

  { -- Collection of various small independent plugins/modules
    'nvim-mini/mini.nvim',
    config = function()
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

      -- Buffer tabs
      require('mini.tabline').setup()

      -- Git diff
      require('mini.diff').setup()

      -- Move selection
      require('mini.move').setup()

      -- Colorize HEX colors
      require('mini.hipatterns').setup { highlighters = { hex_color = require('mini.hipatterns').gen_highlighter.hex_color() } }

      -- Status line
      require('mini.statusline').setup { use_icons = true }

      -- Better comments
      require('mini.comment').setup()

      -- Picker
      local win_config = function()
        local height = math.floor(0.618 * vim.o.lines)
        local width = math.floor(0.618 * vim.o.columns)
        return {
          anchor = 'NW',
          height = height,
          width = width,
          row = math.floor(0.5 * (vim.o.lines - height)),
          col = math.floor(0.5 * (vim.o.columns - width)),
        }
      end
      require('mini.pick').setup {
        use_cache = true,
        window = { config = win_config },
      }

      -- Extra
      require('mini.extra').setup()

      -- Picker keybinds
      local builtins = MiniPick.builtin
      map('<leader>sh', builtins.help, '[S]earch [H]elp')
      map('<leader>sf', builtins.files, '[S]earch [F]iles')
      map('<leader>sw', function()
        builtins.grep { pattern = vim.fn.expand '<cword>' }
      end, '[S]earch current [W]ord', { 'n', 'x' })
      map('<leader>sg', builtins.grep, '[S]earch by [G]rep')
      map('<leader>sd', MiniExtra.pickers.diagnostic, '[S]earch [D]iagnostics')
      map('<leader>sk', MiniExtra.pickers.keymaps, '[S]earch [K]eymaps')
      map('<leader>/', MiniExtra.pickers.buf_lines, '[/] Fuzzily search in current buffer')
      map('<leader><leader>', builtins.buffers, '[ ] Find existing buffers')

      -- Indent scope
      require('mini.indentscope').setup {
        draw = {
          animation = require('mini.indentscope').gen_animation.none(),
        },
      }
    end,
  },
}
