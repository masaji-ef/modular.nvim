return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = function()
    local function check_cmd(cmd)
      local handle = io.popen('command -v ' .. cmd .. ' 2>/dev/null')
      if not handle then return false end
      local result = handle:read('*a'):gsub('\n', '')
      handle:close()
      return result ~= ''
    end

    local function install_ts_cli()
      if check_cmd('tree-sitter') then return end
      vim.notify('Installing tree-sitter CLI...', vim.log.levels.INFO)
      local os_name = vim.loop.os_uname().sysname
      local install_cmd

      if os_name == 'Linux' then
        if check_cmd('apt') then
          install_cmd = 'sudo apt install -y tree-sitter-cli'
        elseif check_cmd('dnf') then
          install_cmd = 'sudo dnf install -y tree-sitter-cli'
        elseif check_cmd('yum') then
          install_cmd = 'sudo yum install -y tree-sitter-cli'
        elseif check_cmd('pacman') then
          install_cmd = 'sudo pacman -S --noconfirm tree-sitter-cli'
        elseif check_cmd('apk') then
          install_cmd = 'sudo apk add tree-sitter-cli'
        elseif check_cmd('zypper') then
          install_cmd = 'sudo zypper install -y tree-sitter-cli'
        elseif check_cmd('cargo') then
          install_cmd = 'cargo install tree-sitter-cli'
        elseif check_cmd('npm') then
          install_cmd = 'npm install -g tree-sitter-cli'
        else
          vim.notify('No package manager found. Please install tree-sitter-cli manually.', vim.log.levels.ERROR)
          return
        end
      elseif os_name == 'Darwin' then
        if check_cmd('brew') then
          install_cmd = 'brew install tree-sitter'
        else
          vim.notify('Homebrew not found. Please install tree-sitter-cli manually.', vim.log.levels.ERROR)
          return
        end
      else
        vim.notify('Unsupported OS: ' .. os_name .. '. Please install tree-sitter-cli manually.', vim.log.levels.ERROR)
        return
      end

      local result = os.execute(install_cmd .. ' > /dev/null 2>&1')
      if result == 0 then
        vim.notify('tree-sitter CLI installed successfully!', vim.log.levels.INFO)
      else
        vim.notify('Failed to install tree-sitter CLI. Please install manually.', vim.log.levels.ERROR)
      end
    end

    install_ts_cli()
    vim.cmd('TSUpdate')
  end,
  config = function()
    require('nvim-treesitter').setup {
      install_dir = vim.fn.stdpath('data') .. '/site',
    }

    local langs = { 'c', 'cpp', 'lua', 'python', 'bash', 'markdown', 'markdown_inline' }

    vim.api.nvim_create_autocmd('FileType', {
      pattern = langs,
      callback = function()
        vim.treesitter.start()
      end,
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = langs,
      callback = function()
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo.foldmethod = 'expr'
      end,
    })

    vim.api.nvim_create_user_command('TSInstallAll', function()
      require('nvim-treesitter').install(langs):wait(300000)
      vim.notify('All parsers installed!', vim.log.levels.INFO)
    end, { desc = 'Install all Treesitter parsers' })

    local installed = require('nvim-treesitter').get_installed()
    local missing = vim.tbl_filter(function(lang)
      return not vim.list_contains(installed, lang)
    end, langs)
    if #missing > 0 then
      vim.defer_fn(function()
        require('nvim-treesitter').install(missing):wait(300000)
      end, 1000)
    end
  end,
}
