-- bootstrap
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

require('lazy').setup({
  -- colorscheme
  {
    'RRethy/nvim-base16',
    config = function() require('plugins.base16') end,
    priority = 1000
  },

  -- nerdfont icons
  {
    'echasnovski/mini.icons',
    version = false,
    config = function () require('plugins.mini-icons') end
  },

  -- file browser
  {
    'stevearc/oil.nvim',
    config = function() require('plugins.oil') end,
  },

  -- git
  {
    'NeogitOrg/neogit',
    config = function() require('plugins.git') end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'lewis6991/gitsigns.nvim',
      'sindrets/diffview.nvim',
    },
    event = 'VeryLazy'
  },

  -- detect tabstop and shiftwidth automatically
  {
    'tpope/vim-sleuth',
    event = 'VeryLazy'
  },

  -- indent guides
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    config = function() require('plugins.indent_blankline') end,
    event = 'VeryLazy'
  },

  -- visualise rgb and hex values
  {
    'norcalli/nvim-colorizer.lua',
    config = function() require('colorizer').setup() end,
    lazy = true,
    ft = {
      'css', 'html', 'javascript', 'typescript', 'lua', 'vim', 'markdown',
      'yaml', 'toml'
    }
  },

  -- surround text objects
  {
    'kylechui/nvim-surround',
    config = function() require('plugins.nvim_surround') end,
    version = '*',
    event = 'VeryLazy'
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    config = function() require('plugins.lsp') end,
    dependencies = {
      -- automatically install servers
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
    },
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }
  },

  -- autocompletion
  {
    'hrsh7th/nvim-cmp',
    config = function() require('plugins.cmp') end,
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',             -- snippet engine
      'saadparwaiz1/cmp_luasnip',     -- cmp source for snippet engine
      'rafamadriz/friendly-snippets', -- collection of premade snippets
      {
        'folke/lazydev.nvim',         -- nvim-specific lua config
        config = function() require('lazydev').setup() end,
        ft = 'lua'
      },
    },
    event = 'InsertEnter'
  },

  -- visualise undo history
  {
    'mbbill/undotree',
    config = function() require('plugins.undotree') end,
    event = 'VeryLazy'
  },

  -- fuzzy finder
  {
    'ibhagwan/fzf-lua',
    config = function() require('plugins.fzf') end,
    event = 'VeryLazy'
  },

  -- effortless file navigation
  {
    'ThePrimeagen/harpoon',
    config = function() require('plugins.harpoon') end,
    branch = 'harpoon2',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    event = 'VeryLazy'
  },

  -- syntax hl
  {
    'nvim-treesitter/nvim-treesitter',
    config = function() require('plugins.treesitter') end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate'
  },
})

