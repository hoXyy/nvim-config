local function any_client_supports(bufnr, capability)
  for _, client in ipairs(vim.lsp.get_clients { bufnr = bufnr }) do
    if client.server_capabilities[capability] then
      return true
    end
  end
  return false
end

-- server configs
local vue_plugin = {
  name = '@vue/typescript-plugin',
  location = vim.fn.expand '$MASON/packages' .. '/vue-language-server' .. '/node_modules/@vue/language-server',
  languages = { 'vue' },
  configNamespace = 'typescript',
}

require('lazydev').setup {
  library = {
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
}

local servers = {
  lua_ls = {
    Lua = {
      completion = {
        callSnippet = 'Replace',
      },
      diagnostics = { disable = { 'missing-fields' } },
    },
  },
  vtsls = {
    settings = {
      vtsls = {
        experimental = {
          maxInlayHintLength = 30,
        },
        tsserver = {
          globalPlugins = {
            vue_plugin,
          },
        },
      },
      typescript = {
        inlayHints = {
          parameterNames = { enabled = 'all', suppressWhenArgumentMatchesName = true },
          parameterTypes = { enabled = true },
          variableTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          enumMemberValues = { enabled = true },
        },
      },
      javascript = {
        inlayHints = {
          parameterNames = { enabled = 'all', suppressWhenArgumentMatchesName = true },
          parameterTypes = { enabled = true },
          variableTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          enumMemberValues = { enabled = true },
        },
      },
    },
    on_attach = function(client)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end,
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
  },
  eslint = {
    settings = {
      codeActionOnSave = {
        enable = true,
        mode = 'all',
      },
    },
  },
  vue_ls = {},
  jsonls = {
    settings = {
      json = {
        validate = { enable = true },
        schemas = {
          {
            fileMatch = { 'package.json' },
            url = 'https://www.schemastore.org/package.json',
          },
          {
            fileMatch = { 'prettierrc.json' },
            url = 'https://www.schemastore.org/prettierrc.json',
          },
        },
      },
    },
  },
  yamlls = {
    settings = {
      validate = true,
      schemaStore = { enable = false, url = '' },
      schemas = {
        ['https://raw.githubusercontent.com/compose-spec/compose-go/master/schema/compose-spec.json'] = 'docker-compose*.{yml,yaml}',
      },
    },
  },
  cssls = {},
  astro = {},
  tailwindcss = {},
  gh_actions_ls = {},
}

-- overall LSP setup
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    border = 'rounded',
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = false }),
  callback = function(event)
    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    if any_client_supports(event.buf, 'documentHighlightProvider') then
      local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
        end,
      })
    end
  end,
})

for server, config in pairs(servers) do
  vim.lsp.config(
    server,
    vim.tbl_deep_extend('force', config, {
      capabilities = require('cmp_nvim_lsp').default_capabilities(),
    })
  )
  vim.lsp.enable(server)
end
