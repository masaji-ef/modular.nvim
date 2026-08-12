return {
  'folke/which-key.nvim',
  lazy = false,
  opts = {
    preset = 'modern',
    delay = function(ctx)
      return ctx.plugin and 0 or 200
    end,
    triggers = { { '<leader>', mode = { 'n', 'v' } } },
    spec = {
      { '<leader>f', group = 'File' },
      { '<leader>s', group = 'Search' },
      { '<leader>l', group = 'LSP' },
      { '<leader>t', group = 'Trouble' },
      { '<leader>h', group = 'Harpoon' },
      { '<leader>d', group = 'Delete' },
      { '<leader>r', group = 'Replace' },
    },
    icons = {
      mappings = true,
      group = '+',
      separator = '➜',
      breadcrumb = '»',
    },
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
      presets = {
        operators = true,
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
  },
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show { global = false }
      end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
  },
}
