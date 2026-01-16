require('snacks').setup {
  picker = {
    enabled = true,
    layout = 'telescope',
    layouts = {
      telescope = {
        reverse = true,
        layout = {
          box = 'horizontal',
          backdrop = false,
          width = 0.8,
          height = 0.9,
          border = 'none',
          {
            box = 'vertical',
            { win = 'list', title = ' Results ', title_pos = 'center', border = true },
            { win = 'input', height = 1, border = true, title = '{title} {live} {flags}', title_pos = 'center' },
          },
          {
            win = 'preview',
            title = '{preview:Preview}',
            width = 0.45,
            border = true,
            title_pos = 'center',
          },
        },
      },
    },
  },
  input = {
    enabled = true,
  },
}

local map = require('helpers.keymap').map

-- Picker
map('<leader>sh', function()
  Snacks.picker.help()
end, '[S]earch [H]elp')
map('<leader>sf', function()
  Snacks.picker.files()
end, '[S]earch [F]iles')
map('<leader>sn', function()
  Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
end, '[S]earch [N]eovim Config')
map('<leader><leader>', function()
  Snacks.picker.buffers()
end, '[ ] Find existing buffers')
map('<leader>/', function()
  Snacks.picker.grep_buffers()
end, '[S]earch Buffer')
map('<leader>sg', function()
  Snacks.picker.grep()
end, '[S]earch [G]rep Files')
map('<leader>sd', function()
  Snacks.picker.diagnostics()
end, '[S]earch [D]iagnostics')
map('<leader>sk', function()
  Snacks.picker.keymaps()
end, '[S]earch [K]eymaps')
map('<leader>sC', function()
  Snacks.picker.commands()
end, '[S]earch [C]ommands')

-- Lazygit
map('<leader>lg', function()
  Snacks.lazygit()
end, 'Open [L]azy[G]it')

-- LSP renaming
vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesActionRename',
  callback = function(event)
    Snacks.rename.on_rename_file(event.data.from, event.data.to)
  end,
})
