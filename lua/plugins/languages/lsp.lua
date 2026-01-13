-- lua
require('lazydev').setup {
  library = {
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
}

vim.lsp.config('lua_ls', {
  Lua = {
    completion = {
      callSnippet = 'Replace',
    },
    diagnostics = { disable = { 'missing-fields' } },
  },
})

-- typescript
local vue_plugin = {
  name = '@vue/typescript-plugin',
  location = vim.fn.expand '$MASON/packages' .. '/vue-language-server' .. '/node_modules/@vue/language-server',
  languages = { 'vue' },
  configNamespace = 'typescript',
}

vim.lsp.config('vtsls', {
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
})

-- eslint
vim.lsp.config('eslint', {
  settings = {
    codeActionOnSave = {
      enable = true,
      mode = 'all',
    },
  },
})

vim.lsp.enable { 'lua_ls', 'vtsls', 'eslint', 'vue_ls', 'jsonls', 'cssls', 'astro' }
