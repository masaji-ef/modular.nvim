---@diagnostic disable: missing-fields
return {
  {
    'echasnovski/mini.icons',
    version = '*',
    config = function()
      require('mini.icons').setup()
    end,
  },
  {
    'echasnovski/mini.move',
    version = '*',
    config = function()
      require('mini.move').setup {
        mappings = {
          left = '<A-h>',
          right = '<A-l>',
          down = '<A-j>',
          up = '<A-k>',
          line_left = '<A-h>',
          line_right = '<A-l>',
          line_down = '<A-j>',
          line_up = '<A-k>',
        },
        options = {
          reindent_linewise = true,
        },
      }
    end,
  },
  {
    'echasnovski/mini.comment',
    version = '*',
    config = function() end,
  },
  {
    'echasnovski/mini.indentscope',
    version = '*',
    config = function()
      require('mini.indentscope').setup {
        draw = {
          delay = 50,
          animation = require('mini.indentscope').gen_animation.none(),
        },
        mappings = {
          object_scope = 'ii',
          object_scope_with_border = 'ai',
          goto_top = '[i',
          goto_bottom = ']i',
        },
        options = {
          border = 'both',
          indent_at_cursor = true,
          try_as_border = false,
        },
        symbol = '╎',
      }
    end,
  },
  {
    'echasnovski/mini.surround',
    version = '*',
    config = function()
      require('mini.surround').setup {
        custom_surroundings = nil,
        highlight_duration = 500,
        mappings = {
          add = 'sa',
          delete = 'sd',
          find = 'sf',
          find_left = 'sF',
          highlight = 'sh',
          replace = 'sr',
          suffix_last = 'l',
          suffix_next = 'n',
        },
        n_lines = 20,
        respect_selection_type = false,
        search_method = 'cover',
        silent = false,
      }
    end,
  },
  {
    'echasnovski/mini.trailspace',
    version = '*',
    config = function()
      require('mini.trailspace').setup {
        only_in_normal_buffers = true,
      }
    end,
  },
  {
    'echasnovski/mini.cursorword',
    version = '*',
    config = function()
      require('mini.cursorword').setup {
        delay = 100,
      }
    end,
  },
  {
    'echasnovski/mini.hipatterns',
    version = '*',
    config = function()
      local hipatterns = require 'mini.hipatterns'
      hipatterns.setup {
        highlighters = {
          fixme = {
            pattern = '%f[%w]()FIXME()%f[%W]',
            group = 'MiniHipatternsFixme',
          },
          hack = {
            pattern = '%f[%w]()HACK()%f[%W]',
            group = 'MiniHipatternsHack',
          },
          todo = {
            pattern = '%f[%w]()TODO()%f[%W]',
            group = 'MiniHipatternsTodo',
          },
          note = {
            pattern = '%f[%w]()NOTE()%f[%W]',
            group = 'MiniHipatternsNote',
          },
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
        delay = {
          text_change = 200,
          scroll = 50,
        },
      }
    end,
  },
}
