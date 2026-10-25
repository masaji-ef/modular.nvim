return {
  {
    'max397574/better-escape.nvim',
    event = 'InsertEnter',
    config = function()
      require('better_escape').setup {
        timeout = 200,
        default_mappings = true,
        mapping = { j = { k = '<Esc>' } },
      }
    end,
  },
}
