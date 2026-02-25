return {
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    cmd = 'ConformInfo',
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true }
        end,
        mode = 'n',
        desc = 'Format buffer',
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        nix = { 'alejandra' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
      },
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }

        local function has_prettier_eslint_plugin()
          local cwd = vim.fn.getcwd()

          -- npm/yarn: direct node_modules entry
          if vim.fn.isdirectory(cwd .. '/node_modules/eslint-plugin-prettier') == 1 then
            return true
          end

          -- pnpm: virtual store (.pnpm/eslint-plugin-prettier@<version>/...)
          local pnpm_store = cwd .. '/node_modules/.pnpm'
          if vim.fn.isdirectory(pnpm_store) == 1 then
            local matches = vim.fn.glob(pnpm_store .. '/eslint-plugin-prettier@*', false, true)
            if #matches > 0 then
              return true
            end
          end

          return false
        end

        if disable_filetypes[vim.bo[bufnr].filetype] or has_prettier_eslint_plugin() then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
    },
  },
  {
    'windwp/nvim-ts-autotag',
    lazy = false,
    opts = {},
  },
  {
    'NMAC427/guess-indent.nvim',
    config = function()
      require('guess-indent').setup {}
    end,
  },
}
