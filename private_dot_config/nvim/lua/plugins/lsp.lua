return {
  {
    'folke/lazydev.nvim', -- Lua LSP Config with Neovim support
    ft = 'lua',
    dependencies = {
      { 'Bilal2453/luvit-meta', lazy = true },
    },
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },

  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
  },

  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  },

  {
    'neovim/nvim-lspconfig', -- Main LSP Configuration
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('user-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc .. ' [LSP]' })
          end

          -- map("gh", function() vim.lsp.buf.format({ async = true }) end, "Format") -- using conform.nvim
          map('K', vim.lsp.buf.hover, 'Hover')
          map('gk', vim.lsp.buf.signature_help, 'Signature')
          map('gl', vim.diagnostic.open_float, 'Line Diagnostics')
          map('ga', vim.lsp.buf.code_action, 'Code Action', { 'n', 'v' })
          map('gd', vim.lsp.buf.definition, 'Definition')
          map('gD', vim.lsp.buf.declaration, 'Declaration')
          map('gi', vim.lsp.buf.implementation, 'Implementation')
          map('gy', vim.lsp.buf.type_definition, 'Type Definition')
          map('gr', vim.lsp.buf.references, 'References')
          map('gR', vim.lsp.buf.rename, 'Rename')

          -- Workspace keymaps
          map('<leader>lwa', vim.lsp.buf.add_workspace_folder, 'Workspace Add')
          map('<leader>lwr', vim.lsp.buf.remove_workspace_folder, 'Workspace Remove')
          map('<leader>lwl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, 'Workspace List')

          -- Telescope
          local ts = require 'telescope.builtin'
          map('<leader>ltd', ts.lsp_definitions, 'Definitions')
          map('<leader>ltD', ts.lsp_type_definitions, 'Type Definitions')
          map('<leader>ltr', ts.lsp_references, 'References')
          map('<leader>lti', ts.lsp_implementations, 'Implementations')
          map('<leader>lts', ts.lsp_document_symbols, 'Symbols')
          map('<leader>ltS', ts.lsp_dynamic_workspace_symbols, 'Workspace Symbols')

          -- get LSP client
          local client = vim.lsp.get_client_by_id(event.data.client_id)

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>li', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, 'Toggle Inlay Hints')
          end

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('user-lsp-highlight', { clear = false })
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
              group = vim.api.nvim_create_augroup('user-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'user-lsp-highlight', buffer = event2.buf }
              end,
            })
          end
        end,
      })

      -- Change diagnostic symbols in the sign column (gutter)
      local signs = { Error = '', Warn = '', Hint = '', Info = '' }
      for type, icon in pairs(signs) do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      -- Create capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      local servers = {
        bashls = {
          bashIde = {
            globPattern = '*@(.sh|.inc|.bash|.command)',
          },
        },

        dockerls = {
          docker = {
            languageserver = {
              formatter = {
                ignoreMultilineInstructions = true,
              },
            },
          },
        },

        terraformls = {},

        lua_ls = {
          settings = {
            Lua = {
              telemetry = { enable = false },
              format = { enable = false }, -- using stylua with conform.nvim
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },

        golangci_lint_ls = {},
        gopls = {
          cmd = { 'gopls' },
          filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },

          root_dir = require('lspconfig/util').root_pattern('go.work', 'go.mod', '.git'),
          settings = {
            gopls = {
              staticcheck = true,
              usePlaceholders = true,
              completeUnimported = true,
              experimentalPostfixCompletions = true,
              gofumpt = true,
              analyses = {
                unusedparams = true,
                shadow = true,
              },
            },
            hints = {
              rangeVariableTypes = true,
              parameterNames = true,
              constantValues = true,
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              functionTypeParameters = true,
            },
          },
          init_options = {
            usePlaceholders = true,
          },
        },

        ruff = {},
        pyright = {
          pyright = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = 'openFilesOnly',
              useLibraryCodeForTypes = true,
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        -- Other tools used by conform and nvim-lint

        -- bash
        'shfmt', -- shell script formatter
        'shellcheck', -- shell script linter
        'shellharden', -- corrective bash syntax highlighter

        -- lua
        'stylua',

        -- go
        'gofumpt',
        'goimports',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
