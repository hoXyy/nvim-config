return {
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufEnter',
    opts = {
      current_line_blame = true,
      current_line_blame_formatter = ' <author>, <author_time:%R> - <summary> - <abbrev_sha>',
    },
  },
}
