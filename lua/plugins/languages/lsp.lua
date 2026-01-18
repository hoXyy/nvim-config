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
  jsonls = {},
  cssls = {},
  astro = {},
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

for server, config in pairs(servers) do
  vim.lsp.config(server, config)
  vim.lsp.enable(server)
end
