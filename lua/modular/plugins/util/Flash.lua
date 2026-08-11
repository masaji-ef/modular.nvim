return {
  'folke/flash.nvim',
  lazy = false,
  opts = {
    labels = 'asdfghjklqwertyuiopzxcvbnm',
    search = {
      multi_window = true,
      forward = true,
      wrap = true,
      mode = 'fuzzy',
      incremental = false,
      exclude = {
        'notify',
        'cmp_menu',
        'noice',
        'flash_prompt',
        function(win)
          return not vim.api.nvim_win_get_config(win).focusable
        end,
      },
      trigger = '',
      max_length = false,
    },
    jump = {
      jumplist = true,
      pos = 'start',
      history = false,
      register = false,
      nohlsearch = false,
      autojump = false,
      inclusive = nil,
      offset = nil,
    },
    label = {
      uppercase = true,
      exclude = 'hjkliardc',
      current = true,
      after = true,
      before = false,
      style = 'overlay',
      reuse = 'lowercase',
      distance = true,
      min_pattern_length = 0,
      rainbow = { enabled = false },
      format = function(opts)
        return { { opts.match.label, opts.hl_group } }
      end,
    },
    highlight = {
      backdrop = true,
      matches = true,
      priority = 5000,
      groups = {
        match = 'FlashMatch',
        current = 'FlashCurrent',
        backdrop = 'FlashBackdrop',
        label = 'FlashLabel',
      },
    },
    modes = {
      search = {
        enabled = true,
        highlight = { backdrop = false },
        jump = { history = true, register = true, nohlsearch = true },
        search = {},
      },
      char = {
        enabled = true,
        config = function(opts)
          opts.autohide = opts.autohide
            or (vim.fn.mode(true):find 'no' and vim.v.operator == 'y')
          opts.jump_labels = opts.jump_labels
            and vim.v.count == 0
            and vim.fn.reg_executing() == ''
            and vim.fn.reg_recording() == ''
        end,
        autohide = false,
        jump_labels = false,
        multi_line = true,
        label = { exclude = 'hjkliardc' },
        keys = { 'f', 'F', 't', 'T', ';', ',' },
        char_actions = function(motion)
          return {
            [';'] = 'next',
            [','] = 'prev',
            [motion:lower()] = 'next',
            [motion:upper()] = 'prev',
          }
        end,
        search = { wrap = false },
        highlight = { backdrop = true },
        jump = { register = false, autojump = false },
      },
      treesitter = {
        labels = 'abcdefghijklmnopqrstuvwxyz',
        jump = { pos = 'range', autojump = true },
        search = { incremental = false },
        label = { before = true, after = true, style = 'inline' },
        highlight = { backdrop = false, matches = false },
      },
      treesitter_search = {
        jump = { pos = 'range' },
        search = { multi_window = true, wrap = true, incremental = false },
        remote_op = { restore = true },
        label = { before = true, after = true, style = 'inline' },
      },
      remote = {
        remote_op = { restore = true, motion = true },
      },
    },
    prompt = {
      enabled = true,
      prefix = { { '⚡', 'FlashPromptIcon' } },
      win_config = {
        relative = 'editor',
        border = 'none',
        width = 1,
        height = 1,
        row = -1,
        col = 0,
        zindex = 1000,
      },
    },
    remote_op = {
      restore = false,
      motion = false,
    },
  },
  keys = {
    {
      's',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
      desc = 'Flash Jump',
    },
    {
      'S',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').treesitter()
      end,
      desc = 'Flash Treesitter',
    },
    {
      'r',
      mode = 'o',
      function()
        require('flash').remote()
      end,
      desc = 'Flash Remote',
    },
    {
      'R',
      mode = { 'o', 'x' },
      function()
        require('flash').treesitter_search()
      end,
      desc = 'Flash Treesitter Search',
    },
    {
      '<c-s>',
      mode = { 'c' },
      function()
        require('flash').toggle()
      end,
      desc = 'Toggle Flash Search',
    },
  },
}
