return {
  {
    'folke/snacks.nvim',
    lazy = false,
    priority = 1000,
    opts = {
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
    },
    keys = {
      {
        '<leader>sh',
        function()
          Snacks.picker.help()
        end,
        mode = 'n',
        desc = '[S]earch [H]elp',
      },
      {
        '<leader>sf',
        function()
          Snacks.picker.files()
        end,
        mode = 'n',
        desc = '[S]earch [F]iles',
      },
      {
        '<leader>sn',
        function()
          Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
        end,
        mode = 'n',
        desc = '[S]earch [N]eovim Config',
      },
      {
        '<leader><leader>',
        function()
          Snacks.picker.buffers()
        end,
        mode = 'n',
        desc = '[ ] Find existing buffers',
      },
      {
        '<leader>/',
        function()
          Snacks.picker.grep_buffers()
        end,
        mode = 'n',
        desc = '[S]earch Buffer',
      },
      {
        '<leader>sg',
        function()
          Snacks.picker.grep()
        end,
        mode = 'n',
        desc = '[S]earch [G]rep Files',
      },
      {
        '<leader>sd',
        function()
          Snacks.picker.diagnostics()
        end,
        mode = 'n',
        desc = '[S]earch [D]iagnostics',
      },
      {
        '<leader>sk',
        function()
          Snacks.picker.keymaps()
        end,
        mode = 'n',
        desc = '[S]earch [K]eymaps',
      },
      {
        '<leader>sC',
        function()
          Snacks.picker.commands()
        end,
        mode = 'n',
        desc = '[S]earch [C]ommands',
      },
      {
        '<leader>st',
        function()
          Snacks.picker.todo_comments()
        end,
        mode = 'n',
        desc = '[S]earch [T]odo Comments',
      },
      {
        '<leader>lg',
        function()
          Snacks.lazygit()
        end,
        mode = 'n',
        desc = 'Lazygit',
      },
    },
  },
}
