return {
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    opts = {
      ui = {
        border = 'rounded',
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
      registries = {
        'github:mason-org/mason-registry',
      },
    },
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
    },
    opts = {
      automatic_installation = true,
      ensure_installed = {
        'lua_ls',
        'clangd',
        'ruff',
        'bashls',
      },
      handlers = {},
    },
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    opts = {
      ensure_installed = {
        'stylua',
        'ruff',
        'shfmt',
        'prettierd',
        'clang-format',
        'luacheck',
        'shellcheck',
        'yamlfmt',
        'taplo',
      },
      run_on_start = true,
    },
  },
}
