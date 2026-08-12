return {
  {
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
    keys = {
      {
        '<leader>st',
        '<cmd>TodoTelescope<CR>',
        desc = 'Telescope: ToDo Comments',
        mode = 'n',
      },
    },
  },
}
