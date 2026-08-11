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
require 'lazy-plugins'
