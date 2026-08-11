return {
  'stevearc/conform.nvim',
  event = 'VimEnter',
  lazy = false,
  config = function()
    local stylua_config = vim.fn.stdpath 'config' .. '/.stylua.toml'
    local stylua_args
    if vim.fn.filereadable(stylua_config) == 1 then
      stylua_args = { '--config-path', stylua_config, '-' }
    else
      stylua_args = { '--search-parent-directories', '-' }
    end

    require('conform').setup {
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'ruff' },
        sh = { 'shfmt' },
        bash = { 'shfmt' },
        zsh = { 'shfmt' },
        javascript = { 'prettierd' },
        javascriptreact = { 'prettierd' },
        typescript = { 'prettierd' },
        typescriptreact = { 'prettierd' },
        html = { 'prettierd' },
        css = { 'prettierd' },
        json = { 'prettierd' },
        markdown = { 'prettierd' },
        c = { 'clang-format' },
        cpp = { 'clang-format' },
        h = { 'clang-format' },
        hpp = { 'clang-format' },
        objc = { 'clang-format' },
        objcpp = { 'clang-format' },
      },
      formatters = {
        stylua = {
          command = 'stylua',
          args = stylua_args,
          stdin = true,
        },
        ruff = {
          command = 'ruff',
          args = { 'format', '--quiet', '-' },
          stdin = true,
        },
        shfmt = {
          command = 'shfmt',
          args = { '-i', '2', '-s', '-' },
          stdin = true,
        },
        prettierd = {
          command = 'prettierd',
          args = { '--stdin-filepath', '$FILENAME' },
          stdin = true,
        },
        ['clang-format'] = {
          command = 'clang-format',
          args = {
            '--assume-filename',
            '{__FILE}',
            '--style=file',
            '--fallback-style=LLVM',
          },
          stdin = true,
        },
      },
    }

    vim.api.nvim_create_user_command('Format', function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line =
          vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ['end'] = { args.line2, end_line:len() },
        }
      end
      require('conform').format {
        async = true,
        lsp_format = 'fallback',
        range = range,
      }
    end, { desc = 'Format buffer or selection', range = true })

    vim.keymap.set(
      { 'n', 'v' },
      '<leader>f',
      '<cmd>Format<CR>',
      { desc = 'Format buffer or selection' }
    )
  end,
}
