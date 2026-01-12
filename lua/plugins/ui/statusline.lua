local opts = {
  options = {
    theme = 'auto',
    globalstatus = vim.o.laststatus == 3,
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'filetype' },
    lualine_c = { 'filename', 'diagnostics' },
    lualine_x = { 'encoding', 'diff' },
    lualine_y = { 'progress', 'lsp_status' },
    lualine_z = { 'location', 'fileformat' },
  },
}

require('lualine').setup(opts)
