return {
  {
    'echasnovski/mini.icons',
    version = '*',
    config = function()
      require('mini.icons').setup {
        style = 'glyph',
        default = {},
        directory = {},
        extension = {},
        file = {},
        filetype = {},
        lsp = {},
        os = {},
        use_file_extension = function(ext, file)
          return true
        end,
      }
    end,
  },
  {
    'echasnovski/mini.move',
    version = '*',
    config = function()
      require('mini.move').setup {
        mappings = {
          left = '<S-h>',
          right = '<S-l>',
          down = '<S-j>',
          up = '<S-k>',
          line_left = '<S-h>',
          line_right = '<S-l>',
          line_down = '<S-j>',
          line_up = '<S-k>',
        },
        options = {
          reindent_linewise = true,
        },
      }
    end,
  },
  {
    'echasnovski/mini.indentscope',
    version = '*',
    config = function()
      require('mini.indentscope').setup {
        draw = {
          delay = 50,
          animation = require('mini.indentscope').gen_animation.none(),
          predicate = function(scope)
            return not scope.body.is_incomplete
          end,
          priority = 2,
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
          n_lines = 10000,
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
        custom_surroundings = {},
        highlight_duration = 500,
        mappings = {
          add = 'ga',
          delete = 'gd',
          find = 'gf',
          find_left = 'gF',
          highlight = 'gh',
          replace = 'gr',
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
      require('mini.hipatterns').setup {
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
          hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
        },
        delay = {
          text_change = 200,
          scroll = 50,
        },
      }
    end,
  },
}
