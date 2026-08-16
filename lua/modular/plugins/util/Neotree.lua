return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'echasnovski/mini.icons',
    'MunifTanjim/nui.nvim',
    {
      's1n7ax/nvim-window-picker',
      version = '2.*',
      config = function()
        require('window-picker').setup {
          filter_rules = {
            include_current_win = false,
            autoselect_one = true,
            bo = {
              filetype = {
                'neo-tree',
                'neo-tree-popup',
                'notify',
                'NvimTree',
              },
              buftype = { 'terminal', 'quickfix' },
            },
          },
        }
      end,
    },
  },

  config = function()
    for type, icon in pairs {
      Error = ' ',
      Warn = ' ',
      Info = ' ',
      Hint = '󰌵',
    } do
      vim.fn.sign_define(
        'DiagnosticSign' .. type,
        { text = icon, texthl = 'DiagnosticSign' .. type }
      )
    end

    require('neo-tree').setup {
      close_if_last_window = true,
      popup_border_style = 'rounded',
      enable_git_status = true,
      enable_diagnostics = true,
      sort_case_insensitive = true,
      open_files_do_not_replace_types = { 'trouble', 'qf', 'Outline' },
      bind_to_cwd = true,
      default_component_configs = {
        container = {
          enable_character_fade = true,
        },
        indent = {
          indent_size = 2,
          padding = 0,
          with_markers = true,
          indent_marker = '│',
          last_indent_marker = '└',
          highlight = 'NeoTreeIndentMarker',
          expander_collapsed = '',
          expander_expanded = '',
          expander_highlight = 'NeoTreeExpander',
        },
        icon = {
          folder_closed = '',
          folder_open = '',
          folder_empty = '󰜌',
          folder_empty_open = '󰜌',
          default = '*',
          highlight = 'NeoTreeFileIcon',
          provider = function(config, node)
            if node.type == 'file' or node.type == 'terminal' then
              local name = node.name
              local icon, hl = require('mini.icons').get('file', name)
              if not icon then
                icon = config.default or '*'
                hl = 'DevIconDefault'
              end
              return { text = icon, highlight = hl }
            end
          end,
        },
        modified = {
          symbol = '[+] ',
          highlight = 'NeoTreeModified',
        },
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
          highlight = 'NeoTreeFileName',
        },
        git_status = {
          symbols = {
            added = '✚',
            modified = '',
            deleted = '✖',
            renamed = '󰁕',
            untracked = '',
            ignored = '',
            unstaged = '󰄱',
            staged = '',
            conflict = '',
          },
        },
        file_size = {
          enabled = true,
          required_width = 64,
        },
        last_modified = {
          enabled = true,
          required_width = 88,
          format = '%Y-%m-%d %H:%M',
        },
        created = {
          enabled = false,
          required_width = 110,
          format = '%Y-%m-%d',
        },
        symlink_target = {
          enabled = false,
          text_format = function(target)
            return '➛ ' .. target
          end,
        },
      },
      source_selector = {
        winbar = true,
        statusline = false,
        sources = {
          { source = 'filesystem' },
          { source = 'buffers' },
          { source = 'git_status' },
        },
        highlight_tab = 'NeoTreeTabInactive',
        highlight_tab_active = 'NeoTreeTabActive',
        highlight_background = 'NeoTreeTabBackground',
      },
      window = {
        position = 'float',
        width = 35,
        height = 0,
        auto_expand_width = false,
        popup = {
          size = {
            height = '80%',
            width = '40%',
          },
        },
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        mappings = {
          ['<space>'] = 'toggle_node',
          ['<2-LeftMouse>'] = 'open',
          ['<cr>'] = 'open',
          ['<esc>'] = 'cancel',
          ['l'] = 'open',
          ['s'] = 'open_vsplit',
          ['v'] = 'open_split',
          ['t'] = 'open_tabnew',
          ['S'] = 'open_split',
          ['w'] = 'open_with_window_picker',
          ['C'] = 'close_node',
          ['z'] = 'close_all_nodes',
          ['a'] = { 'add', config = { show_path = 'relative' } },
          ['A'] = 'add_directory',
          ['d'] = 'delete',
          ['r'] = 'rename',
          ['y'] = 'copy_to_clipboard',
          ['x'] = 'cut_to_clipboard',
          ['p'] = 'paste_from_clipboard',
          ['c'] = 'copy',
          ['m'] = 'move',
          ['q'] = 'close_window',
          ['R'] = 'refresh',
          ['?'] = 'show_help',
          ['<'] = 'prev_source',
          ['>'] = 'next_source',
          ['i'] = 'show_file_details',
          ['h'] = 'close_node',
          ['P'] = { 'toggle_preview', config = { use_float = true } },
          ['ga'] = 'git_add_file',
          ['gu'] = 'git_unstage_file',
          ['gr'] = 'git_revert_file',
          ['gc'] = 'git_commit',
          ['gp'] = 'git_push',
          ['gg'] = 'git_commit_and_push',
          ['/'] = 'fuzzy_finder',
          ['f'] = 'filter_on_submit',
          ['<c-x>'] = 'clear_filter',
          ['H'] = 'toggle_hidden',
          ['<bs>'] = 'navigate_up',
          ['.'] = 'set_root',
          ['[g'] = 'prev_git_modified',
          [']g'] = 'next_git_modified',
        },
      },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
          hide_by_name = {
            'node_modules',
            '.git',
            '__pycache__',
            '.venv',
            'venv',
            'env',
            'build',
            'dist',
            'target',
            '*.pyc',
          },
          never_show = { '.DS_Store', 'thumbs.db', '*.swp', '*.swo' },
        },
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },
        group_empty_dirs = true,
        hijack_netrw_behavior = 'open_current',
        use_libuv_file_watcher = true,
      },
      buffers = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },
        group_empty_dirs = true,
        show_unloaded = true,
        window = {
          mappings = {
            ['d'] = 'delete_buffer',
            ['l'] = 'open',
          },
        },
      },
      git_status = {
        window = {
          position = 'float',
          mappings = {
            ['A'] = 'git_add_all',
            ['gu'] = 'git_unstage_file',
            ['ga'] = 'git_add_file',
            ['gr'] = 'git_revert_file',
            ['gc'] = 'git_commit',
            ['gp'] = 'git_push',
            ['gg'] = 'git_commit_and_push',
          },
        },
      },
      document_symbols = {
        window = {
          mappings = {
            ['d'] = 'delete_buffer',
            ['l'] = 'open',
          },
        },
      },
    }

    vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<CR>', {
      desc = 'Neotree float',
    })

    vim.keymap.set('n', '<leader>b', '<cmd>Neotree left<CR>', {
      desc = 'Neotree left',
    })
  end,
}
