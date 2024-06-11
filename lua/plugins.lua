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

  -- file browser
  {
    'stevearc/oil.nvim',
    config = function() require('plugins.oil') end,
    branch = 'master',
    commit = '18272ab'
  },

  -- git
  {
    'NeogitOrg/neogit',
    config = function() require('plugins.git') end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'lewis6991/gitsigns.nvim',
      'sindrets/diffview.nvim'
    },
    event = 'VeryLazy',
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
    event = 'VeryLazy',
  },

  -- visualise rgb and hex values
  {
    'norcalli/nvim-colorizer.lua',
    config = function() require('colorizer').setup() end,
    lazy = true,
    ft = {
      'css', 'html', 'javascript', 'typescript', 'lua', 'vim', 'markdown',
      'yaml', 'toml'
    },
  },

  -- automatically close parentheses, brackets, etc
  {
    'altermo/ultimate-autopair.nvim',
    config = function() require('plugins.autopair') end,
    branch = 'v0.6',
    event = { 'InsertEnter', 'CmdlineEnter' }
  },

  -- surround text objects
  {
    'kylechui/nvim-surround',
    config = function() require('plugins.nvim_surround') end,
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
      'linrongbin16/lsp-progress.nvim',
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
        config = function() require('plugins.lazydev') end,
        ft = 'lua',
        dependencies = {
          { 'Bilal2453/luvit-meta', lazy = true }
        }
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
    'nvim-telescope/telescope.nvim',
    config = function() require('plugins.telescope') end,
    branch = '0.1.x',
    dependencies = {
      'nvim-telescope/telescope-ui-select.nvim', -- vim.ui.select
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
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
    build = ':TSUpdate',
  },
})

