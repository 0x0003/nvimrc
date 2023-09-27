-- bootstrap
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- colorscheme
  'RRethy/nvim-base16',

  -- git
  {
    'lewis6991/gitsigns.nvim',
    config = function() require('plugins.git') end,
    dependencies = {
      'tpope/vim-fugitive',
      'tpope/vim-rhubarb',
    },
  },

  -- detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- indent guides
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function() require('plugins.indent_blankline') end,
    event = 'VeryLazy',
  },

  -- visualise rgb and hex values
  {
    'norcalli/nvim-colorizer.lua',
    config = function() require('colorizer').setup() end,
    lazy = true,
    ft = { 'css', 'html', 'javascript', 'typescript', 'lua', 'vim', 'markdown' },
  },

  -- automatically close parentheses, brackets, etc
  {
    'windwp/nvim-autopairs',
    config = function() require('nvim-autopairs').setup() end,
    event = 'VeryLazy',
  },

  -- surround text objects
  {
    'kylechui/nvim-surround',
    config = function() require('nvim-surround').setup() end,
    version = '*',
    event = 'VeryLazy',
  },

  -- `gc` to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    config = function() require('Comment').setup() end,
    event = 'VeryLazy',
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    config = function() require('plugins.lsp') end,
    dependencies = {
      -- automatically install servers
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      -- status
      { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },
      -- extra nvim-specific lua configuration
      'folke/neodev.nvim',
    },
  },

  -- autocompletion
  {
    'hrsh7th/nvim-cmp',
    config = function() require('plugins.cmp') end,
    dependencies = {
      -- snippet engine and its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      -- LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      -- a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  -- file browser
  {
    'stevearc/oil.nvim',
    config = function() require('plugins.oil') end,
  },

  -- visualise undo history
  {
    'mbbill/undotree',
    config = function() require('plugins.undotree') end,
  },

  -- fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    config = function() require('plugins.telescope') end,
    branch = '0.1.x',
    dependencies = {
      'nvim-telescope/telescope-ui-select.nvim', -- vim.ui.select
      'nvim-lua/plenary.nvim', {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    },
  },

  -- effortless file navigation
  {
    'ThePrimeagen/harpoon',
    config = function() require('plugins.harpoon') end,
    dependencies = {
      'nvim-lua/plenary.nvim'
    }
  },

  -- syntax hl
  {
    'nvim-treesitter/nvim-treesitter',
    config = function() require('plugins.treesitter') end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
})

