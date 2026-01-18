local blink = require 'blink.cmp'

blink.setup {
  keymap = {
    preset = 'enter',

    ['<CR>'] = false,
    ['<Tab>'] = { 'accept', 'fallback' },
  },
  fuzzy = { implementation = 'prefer_rust' },
  appearance = {
    use_nvim_cmp_as_default = false,
    nerd_font_variant = 'mono',
  },
  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 0,
    },
    list = {
      selection = {
        preselect = true,
      },
    },
    menu = {
      scrollbar = false,
      draw = {
        components = {
          kind_icon = {
            text = function(ctx)
              local icon = ctx.kind_icon
              if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                local dev_icon, _ = require('nvim-web-devicons').get_icon(ctx.label)
                if dev_icon then
                  icon = dev_icon
                end
              else
                icon = require('lspkind').symbol_map[ctx.kind]
              end

              return icon .. ctx.icon_gap
            end,
          },
        },
        columns = {
          { 'label' },
          { 'kind_icon', 'kind', 'label_description', gap = 1 },
        },
      },
    },
  },
  sources = {
    default = { 'lsp', 'path', 'buffer' },
    per_filetype = {
      lua = { inherit_defaults = true, 'lazydev' },
      typescript = { 'lsp', 'buffer' }, -- JS/TS LSP already suggests files by itself
      javascript = { 'lsp', 'buffer' },
      typescriptreact = { 'lsp', 'buffer' },
      javascriptreact = { 'lsp', 'buffer' },
    },
    providers = {
      lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
    },
  },
  signature = {
    enabled = true,
    window = {
      show_documentation = true,
    },
    trigger = { enabled = true },
  },
}
