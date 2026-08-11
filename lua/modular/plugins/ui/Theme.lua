return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    style = 'night',
    transparent = false,
    styles = { comments = { italic = true }, keywords = { bold = true }, functions = { bold = true }, variables = {} },
    on_colors = function(colors)
      colors.bg = '#000000'
      colors.bg_dark = '#0a0a0f'
      colors.bg_float = '#0a0a0f'
      colors.bg_highlight = '#1a1a2e'
      colors.bg_popup = '#0a0a0f'
      colors.bg_search = '#1a1a2e'
      colors.bg_sidebar = '#0a0a0f'
      colors.bg_statusline = '#0a0a0f'
      colors.bg_tabline = '#0a0a0f'
      colors.fg = '#ffffff'
      colors.fg_dark = '#a0a0a0'
      colors.fg_float = '#ffffff'
      colors.fg_sidebar = '#ffffff'
      colors.fg_gutter = '#404040'
      colors.comment = '#6e6a86'
      colors.purple = '#bb88ff'
      colors.blue = '#4488ff'
      colors.cyan = '#44ddff'
      colors.green = '#55ff55'
      colors.yellow = '#ffdd44'
      colors.orange = '#ff8800'
      colors.red = '#ff5555'
      colors.magenta = '#ff66aa'
      colors.pink = '#ff66aa'
      colors.teal = '#44ddff'
      colors.white = '#ffffff'
      colors.black = '#000000'
    end,
    on_highlight = function(highlights, colors)
      local hl = highlights
      hl.Normal = { fg = colors.fg, bg = colors.bg }
      hl.NormalNC = { fg = colors.fg_dark, bg = colors.bg }
      hl.CursorLine = { bg = colors.bg_highlight }
      hl.CursorLineNr = { fg = colors.white, bg = colors.bg_highlight }
      hl.Visual = { bg = colors.bg_highlight }
      hl.Search = { fg = colors.black, bg = colors.yellow }
      hl.IncSearch = { fg = colors.black, bg = colors.orange }
      hl.StatusLine = { fg = colors.white, bg = colors.bg_statusline }
      hl.StatusLineNC = { fg = colors.fg_dark, bg = colors.bg_statusline }
      hl.TabLine = { fg = colors.fg_dark, bg = colors.bg_tabline }
      hl.TabLineSel = { fg = colors.white, bg = colors.bg_tabline }
      hl.TabLineFill = { bg = colors.bg_tabline }
      hl.Comment = { fg = colors.comment, italic = true }
      hl.Constant = { fg = colors.blue }
      hl.String = { fg = colors.green }
      hl.Number = { fg = colors.yellow }
      hl.Function = { fg = colors.purple, bold = true }
      hl.Keyword = { fg = colors.red, bold = true }
      hl.Statement = { fg = colors.red }
      hl.Operator = { fg = colors.purple }
      hl.Type = { fg = colors.green }
      hl.Special = { fg = colors.cyan }
      hl.Error = { fg = colors.red, bg = colors.bg }
      hl.Todo = { fg = colors.black, bg = colors.yellow }
      hl.DiagnosticError = { fg = colors.red }
      hl.DiagnosticWarn = { fg = colors.orange }
      hl.DiagnosticInfo = { fg = colors.blue }
      hl.DiagnosticHint = { fg = colors.purple }
      hl.DiagnosticSignError = { fg = colors.red }
      hl.DiagnosticSignWarn = { fg = colors.orange }
      hl.DiagnosticSignInfo = { fg = colors.blue }
      hl.DiagnosticSignHint = { fg = colors.purple }
    end,
  },
  config = function(_, opts)
    require('tokyonight').setup(opts)
    vim.cmd.colorscheme 'tokyonight'
  end,
}
