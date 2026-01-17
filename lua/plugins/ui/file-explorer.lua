vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('nvim-tree').setup {
  hijack_cursor = true,
  view = {
    width = 40,
    preserve_window_proportions = true,
  },
  renderer = {
    highlight_git = true,
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
}

require('helpers.keymap').map('<leader>e', ':NvimTreeToggle<CR>', 'Toggle File Explorer')

require('lsp-file-operations').setup()
