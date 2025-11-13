vim.opt.statuscolumn = '%=%{v:lnum} %{v:relnum ? v:relnum : 0}  '

return {
  -- Colorscheme
  {
    'webhooked/kanso.nvim',
    priority = 1000,
    name = 'kanso',
    lazy = false,
    config = function()
      vim.cmd.colorscheme 'kanso'

      local palette_colors = require('kanso.colors').setup().palette

      require('kanso').setup {
        commentStyle = { italic = false },
        keywordStyle = { italic = false },
        background = {
          dark = 'ink',
        },
        colors = {
          theme = {
            ink = {
              ui = {
                pmenu = {
                  bg = palette_colors.zenBg0,
                  bg_border = palette_colors.zenBg0,
                },
                float = {
                  bg = palette_colors.zenBg0,
                  bg_border = palette_colors.zenBg0,
                },
              },
            },
          },
        },
      }
    end,
  },
  -- Highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = {
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
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- jump forward to textobj
          keymaps = {
            ['af'] = { query = '@function.outer', desc = 'Select outer function' },
            ['if'] = { query = '@function.inner', desc = 'Select inner function' },
            ['ac'] = { query = '@class.outer', desc = 'Select outer class' },
            ['ic'] = { query = '@class.inner', desc = 'Select inner class' },
          },
        },
        move = {
          enable = true,
          goto_next_start = {
            [']f'] = '@function.outer',
            [']c'] = '@class.outer',
          },
          goto_previous_start = {
            ['[f'] = '@function.outer',
            ['[c'] = '@class.outer',
          },
        },
      },
    },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
  },
  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    event = 'VimEnter',
    opts = function()
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

      return opts
    end,
  },
  {
    'norcalli/nvim-colorizer.lua',
  },
}
