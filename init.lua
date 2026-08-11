if vim.fn.has('nvim-0.11.0') == 0 then
  vim.api.nvim_err_writeln('modular.nvim requires Neovim >= 0.11.0')
  return
end

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.have_nerd_font = true

vim.opt.foldenable = false

require 'options'
require 'keymaps'
require 'autocmds'
require 'lazy-bootstrap'
