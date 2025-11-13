return {
  {
    'saghen/blink.cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    version = '1.*',
    dependencies = {
      'folke/lazydev.nvim',
      'onsails/lspkind.nvim',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'enter',
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      completion = {
        -- By default, you may press `<c-space>` to show the documentation.
        -- Optionally, set `auto_show = true` to show the documentation after a delay.
        documentation = { auto_show = true, auto_show_delay_ms = 500 },

        list = {
          selection = {
            preselect = false,
          },
        },

        menu = {
          draw = {
            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  local icon = ctx.kind_icon

                  if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                    local dev_icon, _ = require('nvim-web-devicons').get_icon(ctx.label)
                    if dev_icon then
                      icon = dev_icon
                    end
                  else
                    icon = require('lspkind').symbolic(ctx.kind, {
                      mode = 'symbol',
                    })
                  end

                  return icon .. ctx.icon_gap
                end,
              },
            },
            columns = {
              { 'label', 'label_description', gap = 1 },
              { 'kind_icon', 'kind', 'source_name' },
            },
          },
        },
      },

      sources = {
        default = { 'lsp', 'path', 'buffer', 'lazydev' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },

      fuzzy = { implementation = 'prefer_rust' },

      signature = { enabled = true, window = {
        show_documentation = true,
      }, trigger = { enabled = true } },

      cmdline = {
        completion = {
          ghost_text = { enabled = true },
          menu = {
            auto_show = true,
          },
        },
      },
    },
  },
}
