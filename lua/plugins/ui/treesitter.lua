return {
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter', branch = 'main', build = ':TSUpdate' },
    },
    config = function()
      require('nvim-treesitter-textobjects').setup {
        select = {
          lookahead = true,
        },
      }

      -- Treesitter textobjects keybinds
      -- Select
      vim.keymap.set({ 'x', 'o' }, 'af', function()
        require('nvim-treesitter.textobjects.select').select_textobject('@function.outer', 'textobjects')
      end, { desc = 'Select [a]round [f]unction' })

      vim.keymap.set({ 'x', 'o' }, 'if', function()
        require('nvim-treesitter.textobjects.select').select_textobject('@function.inner', 'textobjects')
      end, { desc = 'Select [i]nside [f]unction' })

      vim.keymap.set({ 'x', 'o' }, 'ac', function()
        require('nvim-treesitter.textobjects.select').select_textobject('@class.outer', 'textobjects')
      end, { desc = 'Select [a]round [c]lass' })

      vim.keymap.set({ 'x', 'o' }, 'ic', function()
        require('nvim-treesitter.textobjects.select').select_textobject('@class.inner', 'textobjects')
      end, { desc = 'Select [i]nside [c]lass' })
    end,
  },
  {
    'MeanderingProgrammer/treesitter-modules.nvim',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter', branch = 'main', build = ':TSUpdate' },
    },
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'css',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vue',
        'vimdoc',
        'typescript',
        'scss',
        'nix',
        'styled',
      },
      highlight = { enable = true },
      auto_install = true,
    },
  },
}
