return {
  'nvim-telescope/telescope.nvim',
  event = 'VeryLazy',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'debugloop/telescope-undo.nvim' },
  },
  config = function()
    local actions = require 'telescope.actions'

    require('telescope').setup {
      defaults = {
        layout_strategy = 'horizontal',
        layout_config = {
          horizontal = { preview_width = 0.5 },
        },
        mappings = {
          i = {
            ['<C-u>'] = actions.move_selection_previous,
            ['<C-d>'] = actions.move_selection_next,
            ['<C-l>'] = actions.select_default,
          },
          n = {
            ['q'] = actions.close,
          },
        },
        file_ignore_patterns = {
          'node_modules',
          '.git',
          '.venv',
        },
        file_previewer = function(...)
          return require('telescope.previewers').vim_buffer_cat.new(...)
        end,
        grep_previewer = function(...)
          return require('telescope.previewers').vim_buffer_vimgrep.new(...)
        end,
        qflist_previewer = function(...)
          return require('telescope.previewers').vim_buffer_qflist.new(...)
        end,
        buffer_previewer_maker = function(...)
          return require('telescope.previewers').buffer_previewer_maker(...)
        end,
      },
      pickers = {
        find_files = {
          hidden = true,
        },
        buffers = {
          initial_mode = 'normal',
          sort_lastused = false,
          sort_mru = false,
          mappings = {
            n = {
              ['d'] = actions.delete_buffer,
              ['l'] = actions.select_default,
            },
          },
        },
        live_grep = {
          additional_args = function(_)
            return { '--hidden' }
          end,
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
        ['undo'] = {},
      },
    }

    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'undo')

    local builtin = require 'telescope.builtin'

    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Telescope: Find Files' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Telescope: Live Grep' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'Telescope: Grep Word' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Telescope: Diagnostics' })
    vim.keymap.set('n', '<leader>sb', builtin.current_buffer_fuzzy_find, { desc = 'Telescope: Current Buffer' })
    vim.keymap.set('n', '<leader>su', '<cmd>Telescope undo<cr>', { desc = 'Telescope: Undo Tree' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Telescope: Keymaps' })
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = 'Telescope: Neovim Files' })
    vim.keymap.set('n', '<leader>s<leader>', builtin.buffers, { desc = 'Telescope: Buffers' })
    vim.keymap.set('n', '<leader>s/', function()
      builtin.current_buffer_fuzzy_find(
        require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        }
      )
    end, { desc = 'Telescope: Current Buffer (alt)' })
  end,
}
