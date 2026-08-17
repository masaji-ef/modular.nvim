-- /lua/modular/health.lua
local M = {}

local function check_neovim_version()
  local ver = vim.version()
  if ver.major >= 0 and ver.minor >= 11 then
    vim.health.ok(
      string.format('Neovim %d.%d.%d', ver.major, ver.minor, ver.patch)
    )
  else
    vim.health.error 'Neovim >= 0.11.0 required'
  end
end

local function check_executables()
  local tools = {
    git = 'Version control',
    make = 'Build tool',
    unzip = 'Archive tool',
    rg = 'Ripgrep (search)',
    fd = 'Find (fast search)',
    stylua = 'Lua formatter',
    ruff = 'Python formatter/linter',
    shfmt = 'Shell formatter',
    prettierd = 'JS/TS formatter',
    ['clang-format'] = 'C/C++ formatter',
  }

  for exe, desc in pairs(tools) do
    if vim.fn.executable(exe) == 1 then
      vim.health.ok(string.format('%s: %s', desc, exe))
    else
      vim.health.warn(string.format('%s not found: %s', desc, exe))
    end
  end
end

local function check_lsp_servers()
  local servers = { 'lua_ls', 'clangd', 'ruff', 'bashls' }
  local mason_path = vim.fn.stdpath 'data' .. '/mason/bin/'

  for _, server in ipairs(servers) do
    local path = mason_path .. server
    if vim.fn.filereadable(path) == 1 or vim.fn.executable(server) == 1 then
      vim.health.ok(string.format('LSP server: %s', server))
    else
      vim.health.warn(string.format('LSP server missing: %s', server))
    end
  end
end

local function check_paths()
  local cache = os.getenv 'HOME' .. '/.cache/nvim'
  local swap = cache .. '/swap'
  local undo = cache .. '/undo'

  if vim.fn.isdirectory(swap) == 1 then
    vim.health.ok('Swap directory: ' .. swap)
  else
    vim.health.warn('Swap directory missing: ' .. swap)
  end

  if vim.fn.isdirectory(undo) == 1 then
    vim.health.ok('Undo directory: ' .. undo)
  else
    vim.health.warn('Undo directory missing: ' .. undo)
  end
end

function M.check()
  vim.health.start '⚡ Custom Neovim Config'

  vim.health.info ''
  vim.health.info '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
  vim.health.info 'NEOVIM'
  vim.health.info '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
  check_neovim_version()

  vim.health.info ''
  vim.health.info '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
  vim.health.info 'PATHS'
  vim.health.info '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
  check_paths()

  vim.health.info ''
  vim.health.info '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
  vim.health.info 'EXECUTABLES'
  vim.health.info '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
  check_executables()

  vim.health.info ''
  vim.health.info '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
  vim.health.info 'LSP SERVERS'
  vim.health.info '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
  check_lsp_servers()
end

return M
