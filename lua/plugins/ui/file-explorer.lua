vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('nvim-tree').setup {
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
}

require('helpers.keymap').map('<leader>e', ':NvimTreeToggle<CR>', 'Toggle File Explorer', 'n', true)

require('lsp-file-operations').setup()
