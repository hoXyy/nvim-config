vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
  {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    keys = {
      {
        '<leader>e',
        '<Cmd>NvimTreeToggle<CR>',
        mode = 'n',
        desc = 'Toggle File Explorer',
      },
    },
    opts = {
      hijack_cursor = true,
      view = {
        width = 40,
        preserve_window_proportions = true,
      },
      renderer = {
        highlight_git = 'icon',
        icons = {
          glyphs = {
            default = '󰈚',
            folder = {
              default = '',
              empty = '',
              empty_open = '',
              open = '',
              symlink = '',
            },
            git = { unmerged = '' },
          },
        },
        indent_markers = {
          enable = true,
        },
      },
      diagnostics = {
        enable = true,
      },
      modified = {
        enable = true,
      },
      filters = {
        git_ignored = false,
      },
    },
  },
  {
    'antosha417/nvim-lsp-file-operations',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-tree.lua',
    },
    config = function()
      require('lsp-file-operations').setup()
    end,
  },
}
