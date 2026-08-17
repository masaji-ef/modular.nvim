vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.undofile = true
vim.opt.fileencoding = 'utf-8'
vim.opt.iskeyword:append '-'

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '81'
vim.opt.showmode = false

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.textwidth = 80

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.list = true
vim.opt.listchars = {
  tab = '  ',
  trail = '·',
  nbsp = '␣',
}

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.updatetime = 1
vim.opt.timeoutlen = 300

vim.opt.inccommand = 'split'
vim.opt.completeopt = 'menuone,noselect'
vim.opt.pumheight = 10
vim.opt.formatoptions:remove { 'c', 'r', 'o', 'a', 't' }

vim.opt.showcmd = true
vim.opt.laststatus = 3
vim.opt.cmdheight = 1
vim.opt.pumblend = 10
vim.opt.winblend = 10
vim.opt.ttimeoutlen = 50

vim.opt.swapfile = true
vim.opt.backup = false
vim.opt.writebackup = false

local cache_dir = os.getenv 'HOME' .. '/.cache/nvim'
vim.fn.mkdir(cache_dir, 'p')
vim.fn.mkdir(cache_dir .. '/swap', 'p')
vim.fn.mkdir(cache_dir .. '/undo', 'p')

vim.opt.directory = cache_dir .. '/swap//'
vim.opt.undodir = cache_dir .. '/undo//'

vim.opt.runtimepath:remove '/usr/share/vim/vimfiles'
