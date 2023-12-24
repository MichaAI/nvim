local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'neovim/nvim-lspconfig'
  use 'powerman/vim-plugin-ruscmd'
  use 'dense-analysis/ale'

  -- зависимости для движка автодополнения
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'

  -- движок автодополнения для LSP
  use 'hrsh7th/nvim-cmp'

  -- парсер для всех языков программирования, цветной код как в твоем
  -- любимом IDE
  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
  }
    
  use 'https://github.com/kyazdani42/nvim-tree.lua'
  use {'kyazdani42/nvim-web-devicons'}
  use('onsails/lspkind-nvim')
  
  use {
    'nvim-lualine/lualine.nvim',
    config = function() require('lualine').setup {
        options = { theme = 'onedark' },
      }
    end
  }

  use 'preservim/nerdtree'

  if packer_bootstrap then
    require('packer').sync()
  end
end)

