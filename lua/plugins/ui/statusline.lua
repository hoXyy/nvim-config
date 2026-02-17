return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      icons_enabled = true,
      theme = 'vague',
      options = {
        globalstatus = vim.o.laststatus == 3,
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = { 'NvimTree' },
        },
      },
      sections = {
        lualine_a = {
          {
            'mode',
            fmt = function(str)
              return ' ' .. str
            end,
          },
        },
        lualine_b = {
          {
            'branch',
            icon = { '', color = { fg = '#A6D4DE' } },
            '|',
          },
        },
        lualine_c = {
          {
            'filename',
            file_status = true,
            path = 0,
          },
          'diagnostics',
        },
        lualine_x = { 'encoding', 'diff' },
        lualine_y = { 'progress', 'lsp_status', 'filetype' },
        lualine_z = { 'location', 'fileformat' },
      },
    },
  },
}
