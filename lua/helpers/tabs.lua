return {
  setTabs = function(num)
    vim.opt.tabstop = num
    vim.opt.shiftwidth = num
    vim.bo.softtabstop = num
    vim.opt.expandtab = true
  end,
}
