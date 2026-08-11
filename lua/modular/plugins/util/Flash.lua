return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {
    labels = 'asdfghjklqwertyuiopzxcvbnm',

    search = {
      multi_window = true, -- искать во всех окнах
      forward = true, -- направление поиска вперёд
      wrap = true, -- зацикливать поиск
      mode = 'fuzzy', -- нечёткий поиск (как в Telescope)
      incremental = false, -- не искать по мере ввода (иначе тормозит)
      exclude = { -- исключить окна, где не нужен flash
        'notify',
        'cmp_menu',
        'noice',
        'flash_prompt',
        function(win)
          return not vim.api.nvim_win_get_config(win).focusable
        end,
      },
      trigger = '', -- нет триггера, сразу вводим буквы
      max_length = false, -- без ограничения длины
    },

    jump = {
      jumplist = true, -- добавлять в историю прыжков
      pos = 'start', -- позиционировать курсор в начало совпадения
      history = false, -- не добавлять в историю поиска
      register = false, -- не сохранять в регистр
      nohlsearch = false, -- не отключать подсветку после прыжка
      autojump = false, -- не прыгать автоматически при одном совпадении (оставляем выбор)
      inclusive = nil, -- автоопределение
      offset = nil,
    },

    label = {
      uppercase = true, -- разрешить заглавные буквы
      exclude = 'hjkliardc', -- исключить буквы, используемые для движения
      current = true, -- показывать метку для первого совпадения
      after = true, -- метка после текста
      before = false, -- не ставить перед
      style = 'overlay', -- поверх текста
      reuse = 'lowercase', -- переиспользовать метки
      distance = true, -- ближайшие к курсору получают метки первыми
      min_pattern_length = 0,
      rainbow = { enabled = false },
      format = function(opts)
        return { { opts.match.label, opts.hl_group } }
      end,
    },

    highlight = {
      backdrop = true, -- затемнять фон
      matches = true, -- подсвечивать совпадения
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
        enabled = true, -- включить интеграцию с / и ?
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
        jump_labels = false, -- не показывать метки при f/t (только подсветка)
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
