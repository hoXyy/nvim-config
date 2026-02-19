return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-path',
      'xzbdmw/colorful-menu.nvim',
      'onsails/lspkind.nvim',
    },
    event = { 'InsertEnter', 'CmdlineEnter' },
    config = function()
      local cmp = require 'cmp'
      local colorful_menu = require 'colorful-menu'
      local lspkind = require 'lspkind'
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'

      local function is_buffer_large(bufnr)
        local filepath = vim.api.nvim_buf_get_name(bufnr)

        if filepath == '' then
          return false -- Unnamed buffer
        end

        local stat = vim.loop.fs_stat(filepath)
        return stat and stat.size > 1000000 -- 1 MB
      end

      colorful_menu.setup {}

      cmp.setup {
        enabled = function()
          local disabled = false
          disabled = disabled or is_buffer_large(vim.api.nvim_get_current_buf())
          return not disabled
        end,

        mapping = cmp.mapping.preset.insert {
          ['<CR>'] = cmp.mapping.confirm { select = true },
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
        },

        formatting = {
          fields = { 'abbr', 'icon', 'kind', 'menu' },

          format = function(entry, vim_item)
            local kind = lspkind.cmp_format {
              mode = 'symbol_text',
            }(entry, vim.deepcopy(vim_item))
            local highlights_info = colorful_menu.cmp_highlights(entry)

            if highlights_info ~= nil then
              vim_item.abbr_hl_group = highlights_info.highlights
              vim_item.abbr = highlights_info.text
            end
            local strings = vim.split(kind.kind, '%s', { trimempty = true })
            vim_item.kind = ' ' .. (strings[1] or '') .. ' '
            vim_item.menu = ''

            return vim_item
          end,
        },

        view = {
          docs = {
            auto_open = true,
          },
        },

        performance = {
          debounce = 0,
          throttle = 1,
          fetching_timeout = 100,
          confirm_resolve_timeout = 1,
          async_budget = 50,
          max_view_entries = 100,
          filtering_context_budget = 100,
        },

        completion = {
          autocomplete = { require('cmp.types').cmp.TriggerEvent.TextChanged },
          completeopt = 'menu,menuone,noinsert',
        },

        window = {
          documentation = cmp.config.window.bordered {
            winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
          },
          completion = cmp.config.window.bordered {
            col_offset = -3,
            side_padding = 1,
          },
        },

        preselect = cmp.PreselectMode.None,

        sources = cmp.config.sources {
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'path' },
          { name = 'buffer' },
        },
      }

      cmp.setup.filetype('lua', {
        sources = cmp.config.sources {
          { name = 'lazydev', group_index = 0 },
          { name = 'nvim_lsp' },
          { name = 'path' },
          { name = 'buffer' },
        },
      })

      local js_ts_filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' }
      for _, ft in ipairs(js_ts_filetypes) do
        cmp.setup.filetype(ft, {
          sources = cmp.config.sources {
            { name = 'nvim_lsp' },
            { name = 'buffer' },
          },
        })
      end

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources {
          { name = 'path' },
          { name = 'cmdline' },
        },
      })

      cmp.setup.cmdline({ '/', '?' }, {
        enabled = vim.bo.filetype ~= 'vim',
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        },
      })

      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },
}
