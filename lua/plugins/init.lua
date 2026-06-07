local plugins = {
  -- colorscheme
  {
    src = 'https://github.com/RRethy/nvim-base16',
    config = 'plugins.base16'
  },

  -- nerdfont icons
  {
    src = 'https://github.com/nvim-mini/mini.icons',
    config = 'plugins.mini-icons'
  },

  -- file browser
  {
    src = 'https://github.com/stevearc/oil.nvim',
    config = 'plugins.oil'
  },

  -- file navigation through custom marks
  {
    src = 'https://github.com/cbochs/grapple.nvim',
    config = 'plugins.grapple',
    events = { 'BufReadPost', 'BufNewFile' },
    pattern = '*'
  },

  -- git
  {
    src = 'https://github.com/tpope/vim-fugitive',
    config = 'plugins.git'
  },
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },

  -- detect tabstop and shiftwidth automatically
  { src = 'https://github.com/tpope/vim-sleuth' },

  -- indent guides
  {
    src = 'https://github.com/lukas-reineke/indent-blankline.nvim',
    config = 'plugins.indent_blankline'
  },

  -- visualize rgb and hex values
  {
    src = 'https://github.com/catgoose/nvim-colorizer.lua',
    config = 'plugins.colorizer',
    events = 'BufEnter',
    pattern = '*'
  },

  -- surround text objects
  {
    src = 'https://github.com/kylechui/nvim-surround',
    version = vim.version.range('4.x'),
    config = 'plugins.nvim_surround'
  },

  -- LSP
  {
    src = 'https://github.com/neovim/nvim-lspconfig',
    config = 'plugins.lsp'
  },
  {
    src = 'https://github.com/folke/lazydev.nvim',
    config = 'plugins.lazydev',
    events = 'FileType',
    pattern = 'lua'
  },

  -- autocompletion
  {
    src = 'https://github.com/hrsh7th/nvim-cmp',
    config = 'plugins.cmp',
    events = 'InsertEnter',
    pattern = '*'
  },
  { src = 'https://github.com/hrsh7th/cmp-nvim-lsp' },
  { src = 'https://github.com/hrsh7th/cmp-buffer' },
  { src = 'https://github.com/hrsh7th/cmp-path' },
  { src = 'https://github.com/L3MON4D3/LuaSnip' },
  { src = 'https://github.com/saadparwaiz1/cmp_luasnip' },
  { src = 'https://github.com/rafamadriz/friendly-snippets' },

  -- visualize undo history
  {
    src = 'https://github.com/mbbill/undotree',
    config = 'plugins.undotree'
  },

  -- fuzzy finder
  {
    src = 'https://github.com/ibhagwan/fzf-lua',
    config = 'plugins.fzf'
  },

  -- syntax hl
  {
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    config = 'plugins.treesitter'
  },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' }
}

vim.pack.add(vim.tbl_map(function(plugin)
  return {
    src = plugin.src,
    version = plugin.version,
  }
end, plugins))

local pack_startup = Aug('pack_startup', { clear = true })

for _, plugin in ipairs(plugins) do
  if plugin.config then
    local config = plugin.config
    local function load()
      local ok, err = pcall(require, config)
      if not ok then
        error(('Failed loading plugin config "%s":\n%s'):format(config, err))
      end
    end
    if plugin.events then
      Auc(plugin.events, {
        group = pack_startup,
        once = true,
        pattern = plugin.pattern,
        callback = load,
      })
    else
      load()
    end
  end
end

Auc('PackChanged', {
  group = pack_startup,
  callback = function(ev)
    local spec = ev.data and ev.data.spec
    if spec and spec.name == 'nvim-treesitter' then
      vim.cmd('TSUpdate')
    end
  end,
})

