local mappings = {
  {
    'x',
    '<leader>p',
    [["_dP]],
    'Paste without overwriting clipboard',
  },
  { { 'n', 'v' }, '<leader>d', [["_d]], 'Delete w/o yank' },
  {
    'v',
    'p',
    '"_dP',
    'Paste without losing last yanked text',
  },
  {
    'n',
    'x',
    '"_x',
    'Delete character without copying',
  },
  {
    'n',
    '<Esc>',
    '<cmd>nohlsearch<CR>',
    'Clear search highlights',
  },
  {
    'n',
    '<C-d>',
    '<C-d>zz',
    'Scroll down and center',
  },
  {
    'n',
    '<C-u>',
    '<C-u>zz',
    'Scroll up and center',
  },
  {
    'v',
    '<',
    '<gv',
    'Stay in indent mode when shifting left',
  },
  {
    'v',
    '>',
    '>gv',
    'Stay in indent mode when shifting right',
  },
  {
    'n',
    'n',
    'nzzzv',
    'Search next occurrence and center',
  },
  {
    'n',
    'N',
    'Nzzzv',
    'Search previous occurrence and center',
  },
  { 'n', '<leader>q', '<cmd>q<CR>', 'Close' },
  { 'n', 'q', '<nop>', 'Disable q' },
  {
    { 'n', 'i', 'v', 'x', 't', 'c', 's', 'o' },
    '<Up>',
    '<nop>',
    'Disable arrows',
  },
  {
    { 'n', 'i', 'v', 'x', 't', 'c', 's', 'o' },
    '<Down>',
    '<nop>',
    'Disable arrows',
  },
  {
    { 'n', 'i', 'v', 'x', 't', 'c', 's', 'o' },
    '<Left>',
    '<nop>',
    'Disable arrows',
  },
  {
    { 'n', 'i', 'v', 'x', 't', 'c', 's', 'o' },
    '<Right>',
    '<nop>',
    'Disable arrows',
  },
}

local opts = { noremap = true, silent = true }

local function desc(str)
  return vim.tbl_extend('force', opts, { desc = str })
end

for _, map in ipairs(mappings) do
  vim.keymap.set(map[1], map[2], map[3], desc(map[4]))
end

local function escape_pattern(str)
  return str:gsub('[%%%.%+%-%*%?%^%$%(%)%[%]]', '%%%1')
end

local function escape_replace(str)
  return str:gsub('[%%\\]', '%%%1')
end

vim.keymap.set('n', '<leader>r', function()
  vim.ui.input(
    { prompt = 'Search for: ', default = vim.fn.expand '<cword>' },
    function(search)
      if not search or search == '' then
        return
      end

      local escaped_search = escape_pattern(search)
      if vim.fn.search(escaped_search, 'nw') == 0 then
        return vim.notify(
          '❌ Pattern not found: ' .. search,
          vim.log.levels.WARN
        )
      end

      vim.ui.input({ prompt = 'Replace with: ' }, function(replace)
        if not replace then
          return
        end
        vim.cmd(
          string.format(
            '%%s/\\C%s/%s/gc',
            escaped_search,
            escape_replace(replace)
          )
        )
        vim.cmd 'normal! ``'
      end)
    end
  )
end, { desc = 'Smart replace' })

-- FIXME: temp solution
vim.keymap.set('n', 's', '<nop>', { noremap = true, silent = true })
vim.keymap.set('n', 'S', '<nop>', { noremap = true, silent = true })
vim.keymap.set('n', 'r', '<nop>', { noremap = true, silent = true })
vim.keymap.set('n', 'R', '<nop>', { noremap = true, silent = true })

vim.keymap.set('x', 's', '<nop>', { noremap = true, silent = true })
vim.keymap.set('x', 'S', '<nop>', { noremap = true, silent = true })
vim.keymap.set('x', 'r', '<nop>', { noremap = true, silent = true })
vim.keymap.set('x', 'R', '<nop>', { noremap = true, silent = true })

vim.keymap.set('o', 's', '<nop>', { noremap = true, silent = true })
vim.keymap.set('o', 'S', '<nop>', { noremap = true, silent = true })
vim.keymap.set('o', 'r', '<nop>', { noremap = true, silent = true })
vim.keymap.set('o', 'R', '<nop>', { noremap = true, silent = true })

vim.keymap.set('n', 'gf', '<nop>', { noremap = true, silent = true })
vim.keymap.set('n', 'gF', '<nop>', { noremap = true, silent = true })
vim.keymap.set('x', 'gf', '<nop>', { noremap = true, silent = true })
vim.keymap.set('x', 'gF', '<nop>', { noremap = true, silent = true })

-- FIXME: mini.move
vim.keymap.set(
  'n',
  '<leader>lk',
  vim.lsp.buf.hover,
  { desc = 'LSP: Hover Documentation' }
)
