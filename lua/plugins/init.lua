return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'powerman/vim-plugin-ruscmd'
  use 'dense-analysis/ale'
 
  -- набор Lua функций, используется как зависимость в большинстве
  -- плагинов, где есть работа с асинхронщиной
  use 'nvim-lua/plenary.nvim'
  use 'andweeb/presence.nvim'
  -- конфиги для LSP серверов, нужен для простой настройки и
  -- возможности добавления новых серверов
   use({
    "neovim/nvim-lspconfig",
    requires = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("_lsp").setup()
    end,
  })
    use { "jose-elias-alvarez/null-ls.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("_null-ls")
    end
  }
  -- зависимости для движка автодополнения
  use 'hrsh7th/cmp-nvim-lsp' 
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-calc'
  use 'f3fora/cmp-spell'
  use 'tamago324/cmp-zsh'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'hrsh7th/nvim-cmp'

  -- Иконки для расширений файлов (для корректной работы нужен
  -- установленный один из Nerd шрифтов в терминале) - опционален
  -- https://github.com/ryanoasis/nerd-fonts
  use {
      'kyazdani42/nvim-web-devicons',
      config = function()
        require('nvim-web-devicons').setup({ default = true; })
      end
  }
    
  -- движок сниппетов
  use {
    'L3MON4D3/LuaSnip',
    after = 'friendly-snippets',
    config = function()
      require('luasnip/loaders/from_vscode').load({
       paths = { '~/.local/share/nvim/site/pack/packer/start/friendly-snippets' }
      })
    end
  }
    
  -- автодополнения для сниппетов
  use 'saadparwaiz1/cmp_luasnip'
    
  -- набор готовых сниппетов для всех языков, включая go
  use 'rafamadriz/friendly-snippets'

  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
  }
    
  use('onsails/lspkind-nvim')
  
  use {
    'nvim-lualine/lualine.nvim',
    config = function() require('lualine').setup {
        options = { theme = 'onedark' },
      }
    end
  }

  use 'preservim/nerdtree'
    

  use {
	"windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }

 use {
     'prettier/vim-prettier',
	     run = 'yarn install --frozen-lockfile --production',
     ft = {'javascript', 'typescript', 'css', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'}
	   }

  if packer_bootstrap then
    require('packer').sync()
  end
end)

