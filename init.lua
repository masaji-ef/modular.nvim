if vim.fn.has 'nvim-0.11.0' == 0 then
  vim.api.nvim_err_writeln 'modular.nvim requires Neovim >= 0.11.0'
  return
end

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.have_nerd_font = true

-- Отключаем провайдеры (убирает предупреждения в vim.provider)
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- Отключаем проверку языков в Mason (если поддерживается)
vim.g.mason_disable_language_checks = true

vim.opt.foldenable = false

require 'options'
require 'keymaps'
require 'autocmds'
require 'lazy-bootstrap'
