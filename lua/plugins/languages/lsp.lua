return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = 'snacks.nvim', words = { 'Snacks' } },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'j-hui/fidget.nvim', opts = {} },
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      -- Dynamic TypeScript SDK finder with pnpm support
      local get_tsdk = (function()
        local cache = {}
        local max_depth = 10

        local function parse_version(dirname)
          local major, minor, patch = dirname:match '^typescript@(%d+)%.(%d+)%.(%d+)'
          if major then
            return tonumber(major) * 10000 + tonumber(minor) * 100 + tonumber(patch)
          end
          return 0
        end

        local function find_in_pnpm(base_path)
          local pattern = base_path .. '/node_modules/.pnpm/typescript@*/node_modules/typescript/lib'
          local matches = vim.fn.glob(pattern, false, true)

          if #matches == 0 then
            return nil
          end
          if #matches == 1 then
            return matches[1]
          end

          -- Sort by version and return highest
          table.sort(matches, function(a, b)
            return parse_version(vim.fn.fnamemodify(a, ':h:h:h:t')) > parse_version(vim.fn.fnamemodify(b, ':h:h:h:t'))
          end)
          return matches[1]
        end

        local function check_shamefully_hoist(path)
          local npmrc = path .. '/.npmrc'
          if vim.fn.filereadable(npmrc) == 1 then
            local content = vim.fn.readfile(npmrc)
            for _, line in ipairs(content) do
              if line:match '^shamefully%-hoist%s*=%s*true' then
                return true
              end
            end
          end
          return false
        end

        return function(root_dir)
          if cache[root_dir] then
            return cache[root_dir]
          end

          local current = root_dir
          local depth = 0

          while current and current ~= '/' and depth < max_depth do
            -- Check pnpm workspace root first
            if vim.fn.filereadable(current .. '/pnpm-workspace.yaml') == 1 then
              local tsdk = find_in_pnpm(current)
              if tsdk then
                cache[root_dir] = tsdk
                return tsdk
              end
            end

            -- Check standard location first if shamefully-hoist
            if check_shamefully_hoist(current) then
              local std_path = current .. '/node_modules/typescript/lib'
              if vim.fn.isdirectory(std_path) == 1 then
                cache[root_dir] = std_path
                return std_path
              end
            end

            -- Check pnpm location
            local pnpm_tsdk = find_in_pnpm(current)
            if pnpm_tsdk then
              cache[root_dir] = pnpm_tsdk
              return pnpm_tsdk
            end

            -- Check standard npm/yarn location
            local std_tsdk = current .. '/node_modules/typescript/lib'
            if vim.fn.isdirectory(std_tsdk) == 1 then
              cache[root_dir] = std_tsdk
              return std_tsdk
            end

            current = vim.fn.fnamemodify(current, ':h')
            depth = depth + 1
          end

          cache[root_dir] = nil
          return nil
        end
      end)()

      local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()

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
        astro = {
          init_options = {
            typescript = {
              tsdk = nil,
            },
          },
          before_init = function(_, config)
            local tsdk = get_tsdk(config.root_dir)
            if not tsdk then
              tsdk = vim.fn.expand '$MASON/packages/typescript-language-server/node_modules/typescript/lib'
            end
            config.init_options.typescript.tsdk = tsdk
          end,
        },
        -- tailwindcss = {},
        gh_actions_ls = {},
      }

      -- overall LSP setup
      vim.diagnostic.config {
        severity_sort = true,
        float = { source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = ' ',
            [vim.diagnostic.severity.WARN] = ' ',
            [vim.diagnostic.severity.INFO] = ' ',
            [vim.diagnostic.severity.HINT] = '󰌵 ',
          },
        },
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          border = 'rounded',
          -- format = function(diagnostic)
          --   local diagnostic_message = {
          --     [vim.diagnostic.severity.ERROR] = ' ' .. diagnostic.message,
          --     [vim.diagnostic.severity.WARN] = ' ' .. diagnostic.message,
          --     [vim.diagnostic.severity.INFO] = ' ' .. diagnostic.message,
          --     [vim.diagnostic.severity.HINT] = '󰌵 ' .. diagnostic.message,
          --   }
          --   return diagnostic_message[diagnostic.severity]
          -- end,
        },
        jump = { float = true, wrap = true },
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
            capabilities = cmp_capabilities,
          })
        )
        vim.lsp.enable(server)
      end
    end,
  },
}
