return {
  map = function(keys, func, desc, mode, silent)
    mode = mode or 'n'
    vim.keymap.set(mode, keys, func, { desc = desc, silent = silent or false })
  end,
}
