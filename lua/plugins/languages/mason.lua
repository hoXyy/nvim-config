require('mason').setup()
require('mason-lspconfig').setup { automatic_enable = false }

require('mason-tool-installer').setup { ensure_installed = { 'lua_ls', 'bashls', 'jsonls', 'html', 'eslint', 'vue_ls', 'cssls', 'astro', 'stylua' } }
