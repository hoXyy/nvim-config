local map = vim.keymap.set

if vim.fn.executable 'lazygit' == 1 then
  map('n', '<leader>lg', function()
    Snacks.lazygit()
  end, { desc = 'Open Lazygit' })
end
