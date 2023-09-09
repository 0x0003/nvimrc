-- set leader to spacebar
vim.g.mapleader = " "

-- bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- colorscheme
  {
    'RRethy/nvim-base16',
    config = function()
      require('plugins.colors')
    end,
  },

  -- git
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('plugins.gitsigns')
    end,
  },

  -- detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- indent guides
  {'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('plugins.indent_blankline')
    end,
  },

  -- visualise rgb and hex values
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
    lazy = true,
    ft = {"css", "html", "javascript", "typescript", "lua", "vim", "markdown" },
  },

  -- automatically close parentheses, brackets, etc
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end,
    event = "VeryLazy",
  },

  -- surround text objects
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup()
    end,
    version = "*",
    event = "VeryLazy",
  },

  -- `gc` to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
    event = "VeryLazy",
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('plugins.lsp')
    end,
    dependencies = {
      -- automatically install servers
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      -- status
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
      -- extra nvim-specific lua configuration
      'folke/neodev.nvim',
    },
  },

  -- autocompletion
  {
    'hrsh7th/nvim-cmp',
    config = function()
      require('plugins.cmp')
    end,
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

  -- fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    config = function()
      require('plugins.telescope')
    end,
    branch = '0.1.x',
    dependencies = {
      'nvim-telescope/telescope-file-browser.nvim', -- file browser
      'nvim-telescope/telescope-ui-select.nvim', -- vim.ui.select
      'debugloop/telescope-undo.nvim', -- undo tree
      'nvim-lua/plenary.nvim', { -- NOTE: `make' needs to be present in PATH
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  -- syntax hl
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('plugins.treesitter')
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
})

