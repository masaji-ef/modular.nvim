return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  lazy = true,
  keys = {
    {
      '<leader>a',
      function()
        require('harpoon'):list():add()
      end,
      desc = 'Harpoon: Add',
    },
    {
      '<leader>c',
      function()
        require('harpoon'):list():clear()
      end,
      desc = 'Harpoon: Clear',
    },
    {
      '<leader>j',
      function()
        local harpoon = require 'harpoon'
        local conf = require('telescope.config').values
        local file_paths = {}
        for _, item in ipairs(harpoon:list().items) do
          table.insert(file_paths, item.value)
        end
        require('telescope.pickers')
          .new({}, {
            prompt_title = 'Harpoon',
            finder = require('telescope.finders').new_table {
              results = file_paths,
            },
            previewer = require('telescope.previewers').cat.new {},
            sorter = conf.generic_sorter {},
          })
          :find()
      end,
      desc = 'Harpoon: List',
    },
  },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()
  end,
}
