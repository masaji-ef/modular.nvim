return {
  'folke/which-key.nvim',
  lazy = false,
  priority = 1000,
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = function()
    require('which-key').setup {
      preset = 'modern',
      icons = { mappings = false },
      win = {
        border = 'none',
        padding = { 1, 2 },
        title = true,
        title_pos = 'center',
      },
      layout = { width = { min = 20 }, spacing = 3 },
      sort = { 'local', 'order', 'group', 'alphanum', 'mod' },
      plugins = {
        marks = true,
        registers = true,
        spelling = { enabled = true, suggestions = 20 },
      },
    }

    -- <Space> больше не маппим: which-key сам показывает меню по leader.
    vim.keymap.set('n', '<leader>?', function()
      require('which-key').show { global = false }
    end, { desc = 'Buffer Local Keymaps (which-key)' })
  end,
}
