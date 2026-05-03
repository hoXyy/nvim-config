return {
  {
    'saghen/blink.cmp',
    version = '1.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = 'enter' },
      appearance = {
        nerd_font_variant = 'mono',
      },

      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        list = {
          selection = {
            preselect = true,
            auto_insert = true,
          },
        },
        menu = {
          draw = {
            columns = {
              { 'kind_icon', 'label', gap = 1 },
              { 'kind', 'label_description', gap = 1 },
            },
          },
        },

        ghost_text = {
          enabled = true,
        },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
        per_filetype = {
          typescript = { 'lsp', 'snippets', 'buffer' },
          javascript = { 'lsp', 'snippets', 'buffer' },
          javascriptreact = { 'lsp', 'snippets', 'buffer' },
          typescriptreact = { 'lsp', 'snippets', 'buffer' },
          lua = { inherit_defaults = true, 'lazydev' },
        },
      },

      fuzzy = {
        implementation = 'prefer_rust_with_warning',
      },

      signature = {
        enabled = true,
      },

      cmdline = {
        completion = {
          menu = {
            auto_show = true,
          },
        },
      },
    },
    opts_extend = { 'sources.default' },
  },
}
