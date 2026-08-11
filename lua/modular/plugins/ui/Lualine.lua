return {
  'nvim-lualine/lualine.nvim',
  lazy = false,
  dependencies = {},
  config = function()
    local colors = {
      bg = '#16181b',
      fg = '#c5c4c4',
      yellow = '#e8b75f',
      cyan = '#00bcd4',
      darkblue = '#4f9f22',
      green = '#00e676',
      orange = '#ff7733',
      violet = '#7a3ba8',
      magenta = '#d360aa',
      blue = '#4f9cff',
      red = '#ff3344',
    }

    local function get_mode_color()
      local mode_color = {
        n = colors.darkblue,
        i = colors.violet,
        v = colors.red,
        [''] = colors.blue,
        V = colors.red,
        c = colors.magenta,
        no = colors.red,
        s = colors.orange,
        S = colors.orange,
        [''] = colors.orange,
        ic = colors.yellow,
        R = colors.orange,
        Rv = colors.orange,
        cv = colors.red,
        ce = colors.red,
        r = colors.cyan,
        rm = colors.cyan,
        ['r?'] = colors.cyan,
        ['!'] = colors.red,
        t = colors.red,
      }
      return mode_color[vim.fn.mode()] or colors.fg
    end

    local function get_opposite_color(mode_color)
      local opposite_colors = {
        [colors.red] = colors.cyan,
        [colors.blue] = colors.orange,
        [colors.green] = colors.magenta,
        [colors.magenta] = colors.darkblue,
        [colors.orange] = colors.blue,
        [colors.cyan] = colors.yellow,
        [colors.violet] = colors.green,
        [colors.yellow] = colors.red,
        [colors.darkblue] = colors.violet,
      }
      return opposite_colors[mode_color] or colors.fg
    end

    local function hide_in_width()
      return vim.fn.winwidth(0) > 80
    end

    local function mode()
      local mode_map = {
        n = 'NORMAL',
        i = 'INSERT',
        v = 'VISUAL',
        [''] = 'VISUAL',
        V = 'VISUAL',
        c = 'COMMAND',
        no = 'NORMAL',
        s = 'SELECT',
        S = 'SELECT',
        ic = 'INSERT',
        R = 'REPLACE',
        Rv = 'REPLACE',
        cv = 'COMMAND',
        ce = 'COMMAND',
        r = 'REPLACE',
        rm = 'MORE',
        ['r?'] = 'CONFIRM',
        ['!'] = 'SHELL',
        t = 'TERMINAL',
      }
      return mode_map[vim.fn.mode()] or '[UNKNOWN]'
    end

    local config = {
      options = {
        component_separators = '',
        section_separators = '',
        theme = {
          normal = { c = { fg = colors.fg, bg = colors.bg } },
          inactive = { c = { fg = colors.fg, bg = colors.bg } },
        },
        disabled_filetypes = { 'neo-tree', 'undotree', 'sagaoutline', 'diff' },
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            'location',
            color = function()
              return { fg = colors.fg, gui = 'bold' }
            end,
          },
        },
        lualine_x = {
          {
            'filename',
            color = function()
              return { fg = colors.fg, gui = 'bold,italic' }
            end,
          },
        },
        lualine_y = {},
        lualine_z = {},
      },
    }

    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    ins_left {
      mode,
      color = function()
        local mode_color = get_mode_color()
        return { fg = colors.bg, bg = mode_color, gui = 'bold' }
      end,
      padding = { left = 1, right = 1 },
    }

    ins_left {
      'location',
      color = function()
        return { fg = get_opposite_color(get_mode_color()), gui = 'bold' }
      end,
    }

    ins_left {
      function()
        return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
      end,
      icon = ' ',
      color = function()
        return { fg = get_mode_color(), gui = 'bold' }
      end,
    }

    ins_left {
      'filename',
      file_status = true,
      newfile_status = true,
      path = 0,
      symbols = {
        modified = '  ',
        readonly = '  ',
        unnamed = '  ',
        newfile = '  ',
      },
      color = function()
        return { fg = get_opposite_color(get_mode_color()), gui = 'bold' }
      end,
    }

    ins_left {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      sections = { 'error', 'warn', 'info', 'hint' },
      symbols = {
        error = '  ',
        warn = '  ',
        info = '  ',
        hint = '  ',
      },
      colored = true,
      update_in_insert = true,
      always_visible = false,
      cond = hide_in_width,
    }

    ins_left {
      'selectioncount',
      color = { fg = colors.green, gui = 'bold' },
    }

    ins_left {
      'searchcount',
      color = { fg = colors.green, gui = 'bold' },
    }

    ins_left {
      function()
        local reg = vim.fn.reg_recording()
        return reg ~= '' and '[' .. reg .. ']' or ''
      end,
      color = { fg = colors.red, gui = 'bold' },
      cond = function()
        return vim.fn.reg_recording() ~= ''
      end,
    }

    ins_left {
      function()
        return '%='
      end,
    }

    ins_right {
      'branch',
      icon = '  ',
      fmt = function(branch)
        if branch == '' or branch == nil then
          return 'No Repo'
        end
        local segments = {}
        for segment in branch:gmatch '[^/]+' do
          table.insert(segments, segment)
        end
        for i = 1, #segments - 1 do
          segments[i] = segments[i]:sub(1, 1)
        end
        if #segments == 1 then
          return segments[1]
        end
        segments[1] = segments[1]:upper()
        for i = 2, #segments - 1 do
          segments[i] = segments[i]:lower()
        end
        local truncated_branch = table.concat(segments, '', 1, #segments - 1)
          .. '›'
          .. segments[#segments]
        local max_total_length = 15
        if #truncated_branch > max_total_length then
          truncated_branch = truncated_branch:sub(1, max_total_length) .. '…'
        end
        return truncated_branch
      end,
      color = function()
        return { fg = get_mode_color(), gui = 'bold' }
      end,
    }

    ins_right {
      function()
        local git_status = vim.b.gitsigns_status_dict
        if git_status then
          return string.format(
            '+%d ~%d -%d',
            git_status.added or 0,
            git_status.changed or 0,
            git_status.removed or 0
          )
        end
        return ''
      end,
      icon = ' 󰊢 ',
      color = { fg = colors.yellow, gui = 'bold' },
      cond = hide_in_width,
    }

    ins_right {
      function()
        local msg = 'No LSP'
        local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
        local clients = vim.lsp.get_clients()
        if next(clients) == nil then
          return msg
        end
        local lsp_short_names = {
          pyright = 'py',
          tsserver = 'ts',
          rust_analyzer = 'rs',
          lua_ls = 'lua',
          clangd = 'c++',
          bashls = 'sh',
          jsonls = 'json',
          html = 'html',
          cssls = 'css',
          tailwindcss = 'tw',
          dockerls = 'docker',
          sqlls = 'sql',
          yamlls = 'yml',
        }
        for _, client in ipairs(clients) do
          local filetypes = client.config
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return lsp_short_names[client.name] or client.name:sub(1, 2)
          end
        end
        return msg
      end,
      icon = '  ',
      color = { fg = colors.yellow, gui = 'bold' },
    }

    ins_right {
      'encoding',
      fmt = function(str)
        return ' ' .. str
      end,
    }

    ins_right {
      'fileformat',
      symbols = { unix = '  ', dos = '  ', mac = '  ' },
    }

    require('lualine').setup(config)
  end,
}
