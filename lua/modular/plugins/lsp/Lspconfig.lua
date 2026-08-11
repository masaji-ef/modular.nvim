return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    vim.diagnostic.config {
      virtual_text = true,
      signs = false,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    }

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
    if ok then
      capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
    end

    local on_attach = function(_, bufnr)
      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function()
        vim.lsp.buf.format { async = true }
      end, { desc = 'Format buffer with LSP' })

      local opts = { buffer = bufnr, noremap = true, silent = true }

      vim.keymap.set(
        'n',
        'gd',
        vim.lsp.buf.definition,
        vim.tbl_extend('force', opts, { desc = 'LSP: Go to Definition' })
      )
      vim.keymap.set(
        'n',
        'gD',
        vim.lsp.buf.declaration,
        vim.tbl_extend('force', opts, { desc = 'LSP: Go to Declaration' })
      )
      vim.keymap.set(
        'n',
        'gr',
        vim.lsp.buf.references,
        vim.tbl_extend('force', opts, { desc = 'LSP: Find References' })
      )
      vim.keymap.set(
        'n',
        'gi',
        vim.lsp.buf.implementation,
        vim.tbl_extend('force', opts, { desc = 'LSP: Go to Implementation' })
      )
      vim.keymap.set(
        'n',
        'gt',
        vim.lsp.buf.type_definition,
        vim.tbl_extend('force', opts, { desc = 'LSP: Go to Type Definition' })
      )
      vim.keymap.set(
        'n',
        'K',
        vim.lsp.buf.hover,
        vim.tbl_extend('force', opts, { desc = 'LSP: Hover Documentation' })
      )

      vim.keymap.set(
        'n',
        '<leader>ld',
        vim.lsp.buf.definition,
        vim.tbl_extend('force', opts, { desc = 'LSP: Go to Definition' })
      )
      vim.keymap.set(
        'n',
        '<leader>lD',
        vim.lsp.buf.declaration,
        vim.tbl_extend('force', opts, { desc = 'LSP: Go to Declaration' })
      )
      vim.keymap.set(
        'n',
        '<leader>lr',
        vim.lsp.buf.references,
        vim.tbl_extend('force', opts, { desc = 'LSP: Find References' })
      )
      vim.keymap.set(
        'n',
        '<leader>li',
        vim.lsp.buf.implementation,
        vim.tbl_extend('force', opts, { desc = 'LSP: Go to Implementation' })
      )
      vim.keymap.set(
        'n',
        '<leader>lt',
        vim.lsp.buf.type_definition,
        vim.tbl_extend('force', opts, { desc = 'LSP: Go to Type Definition' })
      )
      vim.keymap.set(
        'n',
        '<leader>lh',
        vim.lsp.buf.hover,
        vim.tbl_extend('force', opts, { desc = 'LSP: Hover Documentation' })
      )
      vim.keymap.set(
        'n',
        '<leader>ls',
        vim.lsp.buf.signature_help,
        vim.tbl_extend('force', opts, { desc = 'LSP: Signature Help' })
      )
      vim.keymap.set(
        'n',
        '<leader>la',
        vim.lsp.buf.code_action,
        vim.tbl_extend('force', opts, { desc = 'LSP: Code Actions' })
      )
      vim.keymap.set(
        'n',
        '<leader>ln',
        vim.lsp.buf.rename,
        vim.tbl_extend('force', opts, { desc = 'LSP: Rename Symbol' })
      )
      vim.keymap.set(
        'n',
        '<leader>lf',
        vim.lsp.buf.format,
        vim.tbl_extend('force', opts, { desc = 'LSP: Format Buffer' })
      )
      vim.keymap.set(
        'n',
        '<leader>lw',
        vim.lsp.buf.workspace_symbol,
        vim.tbl_extend('force', opts, { desc = 'LSP: Workspace Symbols' })
      )
      vim.keymap.set(
        'n',
        '<leader>lF',
        vim.lsp.buf.document_symbol,
        vim.tbl_extend('force', opts, { desc = 'LSP: Document Symbols' })
      )
      vim.keymap.set(
        'n',
        '<leader>l[',
        vim.diagnostic.goto_prev,
        vim.tbl_extend('force', opts, { desc = 'Diagnostic: Previous' })
      )
      vim.keymap.set(
        'n',
        '<leader>l]',
        vim.diagnostic.goto_next,
        vim.tbl_extend('force', opts, { desc = 'Diagnostic: Next' })
      )
      vim.keymap.set(
        'n',
        '<leader>ll',
        function()
          vim.diagnostic.open_float { scope = 'line' }
        end,
        vim.tbl_extend('force', opts, { desc = 'LSP: Show Line Diagnostics' })
      )
    end

    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim', 'setup', 'util' } },
            telemetry = { enable = false },
            runtime = { version = 'LuaJIT' },
            workspace = {
              checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file('', true),
            },
            hint = { enable = true, arrayIndex = 'Disable' },
            codelens = { enable = true },
          },
        },
      },
      clangd = {
        settings = {
          clangd = {
            arguments = {
              '--background-index',
              '--clang-tidy',
              '--header-insertion=iwyu',
              '--completion-style=detailed',
              '--function-arg-placeholders',
              '--fallback-style=llvm',
              '--stdlib=libc++',
            },
            fallbackStyle = 'llvm',
            usePlaceholders = true,
            completeUnimported = true,
            semanticHighlighting = true,
          },
        },
        filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
        root_dir = function(fname)
          return require('lspconfig.util').root_pattern(
            'compile_commands.json',
            'compile_flags.txt',
            '.git',
            'CMakeLists.txt'
          )(fname) or vim.fn.getcwd()
        end,
      },
      ruff = {
        filetypes = { 'python' },
        root_dir = function(fname)
          return require('lspconfig.util').root_pattern(
            'pyproject.toml',
            'requirements.txt',
            '.git',
            'ruff.toml',
            'setup.py'
          )(fname) or vim.fn.getcwd()
        end,
        init_options = {
          settings = { lint = { enable = true }, format = { enable = false } },
        },
      },
      bashls = {
        settings = {
          bash = { diagnostics = { enable = true, globbing = 'warn' } },
        },
      },
    }

    for server, config in pairs(servers) do
      vim.lsp.config(
        server,
        vim.tbl_deep_extend('force', {
          capabilities = capabilities,
          on_attach = on_attach,
          flags = { debounce_text_changes = 150 },
        }, config)
      )
      vim.lsp.enable(server)
    end
  end,
}
