return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = {
      'mason-org/mason.nvim',
      'mason-org/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
    },
    lazy = false,
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup { automatic_enable = false }
      require('mason-tool-installer').setup {
        ensure_installed = {
          { 'lua_ls', version = '3.16.4', auto_update = false },
          'bashls',
          'jsonls',
          'html',
          'eslint',
          'vue_ls',
          'cssls',
          'astro',
          'stylua',
          'yamlls',
          'gh_actions_ls',
          'vtsls',
        },
      }
    end,
  },
}
