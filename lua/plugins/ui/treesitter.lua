return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter-textobjects', opts = {
        select = {
          lookahead = true,
        },
      } },
    },
    config = function()
      local table_except = require('helpers.tables').table_except
      local treesitter = require 'nvim-treesitter'
      treesitter.setup()

      -- adding plugin and other filetypes here to stop warning messages from autoinstall script
      local filetypes_to_ignore = {
        'checkhealth',
        'fidget',
        'snacks_picker_preview',
        'snacks_picker_list',
        'snacks_picker_input',
        'snacks_layout_box',
        'snacks_win_backdrop',
        'snacks_terminal',
        'minifiles',
        'miniicons',
        'gitconfig',
        'NvimTree',
        'help',
        'qf',
        'cmp_menu',
        'cmp_docs',
        'blink-cmp-menu',
        'blink-cmp-documentation',
        'blink-cmp-signature',
        'image',
        'trouble',
        'snacks_input',
        'mason',
        'dropbar_preview',
        'lazy',
        'lazy_backdrop',
      }

      local ensure_installed = {
        'bash',
        'c',
        'css',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vue',
        'vimdoc',
        'typescript',
        'scss',
        'nix',
        'styled',
      }

      treesitter.install(table_except(ensure_installed, treesitter.get_installed()))

      local function detected_ft_cb(args)
        local bufnr = args.buf
        local ft = args.match

        if vim.list_contains(filetypes_to_ignore, ft) then
          return
        end

        if not ft or ft == '' then
          return
        end

        treesitter.install(ft):await(function()
          if vim.list_contains(treesitter.get_installed(), ft) then
            vim.treesitter.start(bufnr)
          end
        end)
      end

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('TreesitterAutoInstall', {
          clear = true,
        }),
        callback = detected_ft_cb,
      })

      require('nvim-treesitter-textobjects').setup {
        select = {
          lookahead = true,
        },
      }

      -- Treesitter textobjects keybinds
      -- Select
      vim.keymap.set({ 'x', 'o' }, 'af', function()
        require('nvim-treesitter.textobjects.select').select_textobject('@function.outer', 'textobjects')
      end, { desc = 'Select [a]round [f]unction' })

      vim.keymap.set({ 'x', 'o' }, 'if', function()
        require('nvim-treesitter.textobjects.select').select_textobject('@function.inner', 'textobjects')
      end, { desc = 'Select [i]nside [f]unction' })

      vim.keymap.set({ 'x', 'o' }, 'ac', function()
        require('nvim-treesitter.textobjects.select').select_textobject('@class.outer', 'textobjects')
      end, { desc = 'Select [a]round [c]lass' })

      vim.keymap.set({ 'x', 'o' }, 'ic', function()
        require('nvim-treesitter.textobjects.select').select_textobject('@class.inner', 'textobjects')
      end, { desc = 'Select [i]nside [c]lass' })
    end,
  },
}
