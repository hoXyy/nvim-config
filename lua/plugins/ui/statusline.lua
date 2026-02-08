local mode = {
  'mode',
  fmt = function(str)
    return ' ' .. str
  end,
}

local branch = { 'branch', icon = { '', color = { fg = '#A6D4DE' } }, '|' }

local filename = {
  'filename',
  file_status = true,
  path = 0,
}

require('lualine').setup {
  icons_enabled = true,
  options = {
    theme = 'nordic',
    globalstatus = vim.o.laststatus == 3,
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = { 'NvimTree' },
    },
  },
  sections = {
    lualine_a = { mode },
    lualine_b = { branch },
    lualine_c = { filename, 'diagnostics' },
    lualine_x = { 'encoding', 'diff' },
    lualine_y = { 'progress', 'lsp_status', 'filetype' },
    lualine_z = { 'location', 'fileformat' },
  },
}
