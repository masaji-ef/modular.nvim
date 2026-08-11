return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufRead', 'BufWritePost', 'TextChanged' },
    config = function()
      local lint = require 'lint'

      local function configure_linter(name, config)
        lint.linters[name] = lint.linters[name] or {}
        for key, value in pairs(config) do
          lint.linters[name][key] = value
        end
      end

      configure_linter('luacheck', {
        cmd = 'luacheck',
        args = {
          '--codes',
          '--ranges',
          '--globals',
          'vim',
          'setup',
          '-',
        },
        stdin = true,
      })

      configure_linter('shellcheck', {
        cmd = 'shellcheck',
        args = {
          '--format=json',
          '$FILENAME',
        },
        stdin = false,
        stream = 'stdout',
        ignore_exitcode = true,
      })

      lint.linters_by_ft = {
        lua = { 'luacheck' },
        sh = { 'shellcheck' },
        bash = { 'shellcheck' },
        zsh = { 'shellcheck' },
      }

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd(
        { 'BufEnter', 'BufWritePost', 'TextChanged', 'InsertLeave' },
        {
          group = lint_augroup,
          callback = function()
            vim.defer_fn(function()
              lint.try_lint()
            end, 150)
          end,
        }
      )

      vim.schedule(function()
        lint.try_lint()
      end)
    end,
  },
}
