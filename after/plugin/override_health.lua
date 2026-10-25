-- Override Mason health check (убирает предупреждения про Ruby, PHP и т.д.)
local ok, mason_health = pcall(require, 'mason.health')
if ok then
  mason_health.check = function()
    vim.health.start('mason.nvim')
    vim.health.ok('mason.nvim is healthy (language checks suppressed)')
  end
end

-- Override which-key health check (убирает предупреждения про наложения и иконки)
local ok2, wk_health = pcall(require, 'which-key.health')
if ok2 then
  wk_health.check = function()
    vim.health.start('which-key.nvim')
    vim.health.ok('which-key.nvim is healthy (overlap checks suppressed)')
  end
end
