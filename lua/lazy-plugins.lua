local function load_plugins()
  local plugins = {}
  local config_path = vim.fn.stdpath 'config' .. '/lua/modular/plugins'

  local files = vim.fn.glob(config_path .. '/**/*.lua', true, true)

  for _, file in ipairs(files) do
    local module = file:match('lua/(.+)%.lua$'):gsub('/', '.')

    if module:match 'health$' then
      goto continue
    end

    local ok, plugin = pcall(require, module)
    if ok and type(plugin) == 'table' and (plugin[1] or plugin.name) then
      table.insert(plugins, plugin)
    end

    ::continue::
  end

  return plugins

end

require('lazy').setup(load_plugins(), {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
  checker = {
    enabled = false,
    frequency = 86400,
    auto_install = false,
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
  install = {
    colorscheme = { 'tokyonight' },
  },
  performance = {
    cache = {
      enabled = true,
      path = vim.fn.stdpath 'cache' .. '/lazy/cache',
    },
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})
