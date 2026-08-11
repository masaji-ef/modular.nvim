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

      local opts = { buffer = bufnr }
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, opts)
      vim.keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help, opts)
      vim.keymap.set('n', '<leader>ld', function()
        vim.diagnostic.open_float { scope = 'line' }
      end, opts)
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
